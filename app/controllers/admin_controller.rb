class AdminController < ApplicationController
  before_action :check_has_access

  def check_has_access
    if current_user
      if current_user.admin
        return true
      end
    end
    redirect_to '/home'
    return false
  end

  def manage_members
    # current_user.admin = true
    # current_user.save()
  end

  def manage_pages
  end

  def manage_events
  end
end
