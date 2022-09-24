class AdminController < ApplicationController
  before_action :check_has_access
  respond_to :js, only: :alert_message

  def manage_members
    @users = User.all
  end

  def manage_pages
  end

  def manage_events
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
      user.save()
      flash.notice = "User #{user.full_name} is now an admin."
    end
    # go back to manage_members
    redirect_to '/manage_members'
  end

  def remove_user_admin
    # get the matching user to the id provided
    user = User.find(params[:userid])
    if !user
      # return error if user does not exist
      flash.alert = "Error: user #{params[:userid]} does not exist."
    elsif !user.admin
      # return error if user is already not an admin
      flash.alert = "Error: user #{user.full_name} is already not an admin."
    else
      # otherwise: change user's admin status to false
      user.admin = false
      user.save()
      flash.notice = "User #{user.full_name} is no longer an admin."
    end
    # go back to manage_members
    redirect_to '/manage_members'
  end

  private

  def check_has_access
    if is_admin
      return true
    end
    flash.alert = "You do not have permission to access this."
    redirect_to home_path
    return false
  end
end
