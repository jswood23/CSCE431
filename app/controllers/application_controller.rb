class ApplicationController < ActionController::Base
  helper_method :is_admin, :is_member, :get_user_status

  def is_admin(user = current_user)
    if user
      if current_user.id == 1 && !current_user.admin
        current_user.admin = true
        current_user.member = true
        current_user.save()
      end
      if user.admin
        return true
      end
    end
    return false
  end

  def is_member(user = current_user)
    if user
      return true
    end
    return false
  end

  def get_user_status(user = current_user)
    if user
      if user.admin
        return "Admin"
      elsif user.member
        return "Member"
      else
        return "User (no permissions)"
      end
    end
    return "Does not exist"
  end
end
