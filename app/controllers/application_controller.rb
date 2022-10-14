# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :admin?, :member?, :get_user_status, :get_name, :get_points

  def admin?(user = current_user)
    if user
      no_admins = User.where(admin: 'true').length.zero?
      if no_admins
        current_user.admin = true
        current_user.member = true
        current_user.save!
        flash.notice = "User #{current_user.full_name} has been made an admin because there were no existing admins."
      end
      if user.admin
        unless user.member
          user.member = true
          user.save!
        end
        return true
      end
    end
    false
  end

  def member?(user = current_user)
    return true if user&.member

    false
  end

  def get_user_status(user = current_user)
    if user
      if user.admin
        return 'Admin'
      elsif user.member
        return 'Member'
      else
        return 'User (no permissions)'
      end
    end
    'Does not exist'
  end

#  def get_name(user = current_user)
#    if user
#      return user.full_name if user.full_name

#      return '(none)'
#    end
#    'Does not exist'
#  end

#  def get_points(user = current_user)
#    info = Information.find_by(user_id: user.id)
#    return info.points if info

#    Rails.logger.debug { "Information db: #{Information.all.count}" }
#    'information object not found'
#  end
end
