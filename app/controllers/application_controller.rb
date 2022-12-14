# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :admin?, :member?, :get_user_status, :get_points, :get_points_type, :attended?, :convert_line_breaks

  def admin?(user = current_user)
    if user
      no_admins = User.where(admin: 'true').length.zero?
      if no_admins
        current_user.admin = true
        current_user.member = true
        current_user.alumni = false
        current_user.save!
        flash.notice = "User #{current_user.full_name} has been made an admin because there were no existing admins."
        return true
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
      elsif user.alumni
        return 'Alumni'
      elsif user.member
        return 'Member'
      else
        return 'User (no permissions)'
      end
    end
    'Does not exist'
  end

  def get_points(user = current_user)
    total_points = 0
    UserScore.where(user_id: user.id).each do |user_score|
      total_points += user_score.score
    end
    total_points
  end

  def get_points_type(id = 1)
    type = PointsType.find(id)
    if type
      type.name
    else
      'Undefined'
    end
  end

  def attended?(event_id)
    AttendanceRecord.where(event_id: event_id, uid: current_user.id).count.positive?
  end

  def convert_line_breaks(input_string)
    # output_string = "<p>#{input_string}<br>howdy</p>"
    output_string = '<p>'
    lines = input_string.split("\n")
    lines.each_with_index do |this_line, index|
      output_string += this_line
      output_string += '<br>' if index < lines.size - 1
    end
    output_string += '</p>'
    # rubocop:disable Rails/OutputSafety
    output_string.html_safe
    # rubocop:enable Rails/OutputSafety
  end
end
