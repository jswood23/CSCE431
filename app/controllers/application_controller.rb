class ApplicationController < ActionController::Base
  helper_method :is_admin

  def is_admin
    if current_user
      if current_user.admin
        return true
      end
    end
    return false
  end
end
