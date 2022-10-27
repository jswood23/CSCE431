# frozen_string_literal: true

class PointsType < ApplicationRecord
  include ApplicationHelper

  after_create do
    create_all_user_scores
  end

  after_update do
    create_all_user_scores
  end

  after_destroy do |this_points_type|
    first_type = PointsType.all.first
    Event.all.find_each do |this_event|
      if this_event.points_type_id == this_points_type.id
        this_event.points_type_id = first_type.id
        this_event.save!
      end
    end
    UserScore.all.find_each do |this_user_score|
      this_user_score.destroy! if this_user_score.points_type_id == this_points_type.id
    end
  end
end
