class ApplicationController < ActionController::Base
  helper_method :is_admin, :get_user_status

  def is_admin(user = current_user)
    if user
      if user.admin
        return true
      end
    end
    return false
  end

  def get_user_status(user = current_user)
    if user
      if user.admin
        return "Admin"
      end
      return "User (no permissions)"
    end
    return "Does not exist"
  end
end
