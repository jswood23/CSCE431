# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]
  before_action :check_has_admin_access, only: %i[index show new edit create update destroy show_attendance remove_from_attendance]
  before_action :check_has_member_access, only: %i[attend_event]

  # GET /events or /events.json
  def index
    # order events by date
    @events_today = Event.where(date: Time.zone.today.all_day)
    @upcoming_events = Event.order('date ASC').where('date > ?', Time.zone.now.end_of_day)
    @past_events = Event.order('date DESC').where('date < ?', Time.zone.now.beginning_of_day)
  end

  # POST /events/1/attend_event/password
  def attend_event
    this_event = Event.find(params[:event_id])
    if this_event.passcode == params[:password]
      new_record = AttendanceRecord.create!(event_id: this_event.id, uid: current_user.id, date_log: DateTime.now, event_name: this_event.event_name,
                                            member_name: current_user.full_name
      )
      new_record.save!
      new_score = this_event.points + UserScore.where(user_id: current_user.id, points_type_id: this_event.points_type_id).first.score
      ActiveRecord::Base.connection.execute("UPDATE user_scores SET score = #{new_score} WHERE user_id = #{current_user.id} AND points_type_id = #{this_event.points_type_id};")
      flash.notice = 'Attended event!'
    else
      flash.notice = 'Incorrect password.'
    end
    redirect_to('/attend')
  end

  # GET events/remove_from_attendance/1/2
  def remove_from_attendance
    if !params[:event_id] || !params[:uid]
      flash.notice = 'Error: event or user not specified.'
      redirect_to('/events')
    else
      this_record = AttendanceRecord.where(event_id: params[:event_id], uid: params[:uid]).first
      if this_record
        this_event = Event.find(this_record.event_id)
        this_user = User.find(this_record.uid)
        new_score = this_event.points - UserScore.where(user_id: this_user.id, points_type_id: this_event.points_type_id).first.score
        ActiveRecord::Base.connection.execute("UPDATE user_scores SET score = #{new_score} WHERE user_id = #{this_user.id} AND points_type_id = #{this_event.points_type_id};")
        member_name = this_record.member_name
        AttendanceRecord.where(event_id: params[:event_id], uid: params[:uid]).delete_all
        flash.notice = "Member #{member_name} has been successfully removed from event."
        redirect_to("/events/show_attendance/#{params[:event_id]}")
      else
        flash.notice = 'Error: event or user not found.'
        redirect_to('/events')
      end
    end
  end

  # GET /events/1 or /events/1.json
  def show; end

  # GET /events/show_attendance/1
  def show_attendance
    @this_event = Event.find(params[:event_id])
    @records = AttendanceRecord.where(event_id: @this_event.id)
  end

  # GET /events/new
  def new
    @event = Event.new
    @points_types = PointsType.all.order('id ASC')
  end

  # GET /events/1/edit
  def edit
    @points_types = PointsType.all.order('id ASC')
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)
    @points_types = PointsType.all.order('id ASC')

    respond_to do |format|
      if @event.save
        format.html { redirect_to(event_url(@event), notice: 'Event was successfully created.') }
        format.json { render(:show, status: :created, location: @event) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @event.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    @points_types = PointsType.all.order('id ASC')
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to(event_url(@event), notice: 'Event was successfully updated.') }
        format.json { render(:show, status: :ok, location: @event) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @event.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy!

    respond_to do |format|
      format.html { redirect_to(events_url, notice: 'Event was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:event_name, :description, :passcode, :date, :points_type_id, :points)
  end

  def check_has_admin_access
    return true if admin?

    flash.alert = 'You do not have permission to access this.'
    redirect_to(home_path)
    false
  end

  def check_has_member_access
    return true if member?

    flash.alert = 'You do not have permission to access this.'
    redirect_to(home_path)
    false
  end
end
