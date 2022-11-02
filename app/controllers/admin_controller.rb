# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :check_has_access
  respond_to :js, only: :alert_message

  # admin pages ('manage_events' redirects to events/index)

  def manage_members
    @members = User.where('member = ? AND alumni = ?', true, false)
    @new_users = User.where(member: [nil, 'false'])
    @alumni = User.where(alumni: 'true')
  end

  def manage_pages
    @pages = Page.all
  end

  def update_points_page
    @points_types = PointsType.all.order('id ASC')
  end

  # Controller actions (without pages)

  def make_user_admin
    # get the matching user to the id provided
    user = User.find(params[:userid])
    if !user
      # return error if user does not exist
      flash.alert = "Error: user #{params[:userid]} does not exist."
    elsif user.admin
      # return error if user is already an admin
      flash.alert = "Error: user #{user.full_name} is already an admin."
    else
      # otherwise: change user's admin status to true
      user.admin = true
      user.member = true
      user.alumni = false
      user.save!
      flash.notice = "User #{user.full_name} is now an admin."
    end
    # go back to manage_members
    redirect_to('/manage_members')
  end

  def make_user_member
    # get the matching user to the id provided
    user = User.find(params[:userid])
    if user
      # otherwise: change user's member status to true
      user.admin = false
      user.member = true
      user.alumni = false
      user.save!
      flash.notice = "User #{user.full_name} is now a member."
    else
      # return error if user does not exist
      flash.alert = "Error: user #{params[:userid]} does not exist."
    end
    # go back to manage_members
    redirect_to('/manage_members')
  end

  def remove_user_member
    # get the matching user to the id provided
    user = User.find(params[:userid])
    if !user
      # return error if user does not exist
      flash.alert = "Error: user #{params[:userid]} does not exist."
    elsif !user.member
      # return error if user is already not a member
      flash.alert = "Error: user #{user.full_name} is already not a member."
    else
      # otherwise: change user's member status to false
      user.member = false
      user.admin = false
      user.alumni = false
      user.save!
      flash.notice = "User #{user.full_name} is no longer a member."
    end
    # go back to manage_members
    redirect_to('/manage_members')
  end

  def make_user_alumni
    user = User.find(params[:userid])
    if user
      # otherwise: change user's alumni status to true
      user.alumni = true
      user.member = true
      user.admin = false
      user.save!
      flash.notice = "User #{user.full_name} is now a alumni."
    else
      flash.alert = "Error: user #{params[:userid]} does not exist."
    end
    # go back to manage_members
    redirect_to('/manage_members')
  end

  def show_user_attendance
    @this_user = User.find(params[:userid])
    @records = AttendanceRecord.where(uid: @this_user.id)
    @scores = UserScore.where(user_id: @this_user.id)
  end

  def change_points_type
    points_type_id = params[:points_type_id]
    if Integer(points_type_id, 10).positive?
      points_type = PointsType.find(points_type_id)
      if points_type
        new_name = params[:name]
        points_type.name = new_name
        points_type.save!
      end
    else
      new_points_type = PointsType.create!(name: 'New Points Type')
      new_points_type.save!
    end
    redirect_to('/update_points')
  end

  def remove_points_type
    if PointsType.all.count <= 1
      flash.notice = 'Error: Cannot remove this points type as no other points types exist.'
    else
      points_type_id = params[:points_type_id]
      points_type = PointsType.find(points_type_id)
      # TODO: add confirmation dialog
      points_type&.destroy!
    end
    redirect_to('/update_points')
  end

  # POST /change_user_attendance/:userid/
  def change_user_points
    this_user = User.find(params[:userid])
    UserScore.where(user_id: this_user.id).each do |user_score|
      new_score = Integer(params[user_score.points_type_name], 10)
      new_score = 0 if new_score.negative?
      # activerecord does not save this correctly so we send a manual sql query
      ActiveRecord::Base.connection.execute("UPDATE user_scores SET score = #{new_score} WHERE user_id = #{this_user.id} AND points_type_id = #{user_score.points_type_id};")
    end
    redirect_to("/show_user_attendance/#{this_user.id}")
  end

  def delete_user
    # get the matching user to the id provided
    user = User.find(params[:userid])
    if !user
      # return error if user does not exist
      flash.alert = "Error: user #{params[:userid]} does not exist."
    elsif user.member || user.admin
      # return error if user is member or admin
      flash.alert = "Error: please remove user's permissions before deletion."
    else
      # otherwise: delete user
      user.destroy!
      flash.notice = "User #{user.full_name} has been successfully deleted."
    end
    # go back to manage_members
    redirect_to('/manage_members')
  end

  private

  def check_has_access
    return true if admin?

    flash.alert = 'You do not have permission to access this.'
    redirect_to(home_path)
    false
  end
end
