class ApplicationController < ActionController::Base
  helper_method :is_admin

  def is_admin(user = current_user)
    if user
      if user.admin
        return true
      end
    end
    return false
  end
end
