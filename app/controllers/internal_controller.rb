# frozen_string_literal: true

class InternalController < ApplicationController
  before_action :check_has_member_access

  def attend
    # order events by date
    @events_today = Event.order('date ASC').where(date: Time.zone.today.all_day)
    @upcoming_events = Event.order('date ASC').where('date > ?', Time.zone.now.end_of_day)
    @past_events = Event.order('date DESC').where('date < ?', Time.zone.now.beginning_of_day)
  end

  def members; end

  def internal_contact
    @members = User.where('member = ? AND alumni = ?', true, false)
    @new_users = User.where(member: [nil, 'false'])
    @alumni = User.where(alumni: 'true')
  end

  # def profile; end

  # Controller actions (without pages)

  def search
    if params[:search].blank?
      redirect_to('/internal_contact') and return
    else
      @parameter = params[:search].downcase
      @results = User.all.where('lower(full_name) LIKE :search', search: "#{@parameter}%")
    end
  end

  private

  def check_has_member_access
    return true if member?

    flash.alert = 'You do not have permission to access this.'
    redirect_to(home_path)
    false
  end
end
