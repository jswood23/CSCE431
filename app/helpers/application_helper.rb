# frozen_string_literal: true

module ApplicationHelper
  def create_all_user_scores
    User.all.each do |this_user|
      PointsType.all.each do |this_points_type|
        if UserScore.where(user_id: this_user.id, points_type_id: this_points_type.id).count.zero?
          UserScore.create!(user_id: this_user.id, points_type_id: this_points_type.id, points_type_name: this_points_type.name, score: 0)
        end
      end
    end
  end
end
