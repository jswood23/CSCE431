# frozen_string_literal: true

class PointsType < ApplicationRecord
  include ApplicationHelper

  after_create do
    create_all_user_scores
  end

  after_update do |points_type|
    create_all_user_scores
    # rubocop:disable Rails/SkipsModelValidations
    UserScore.where(points_type_id: points_type.id).update_all(points_type_name: points_type.name)
    # rubocop:enable Rails/SkipsModelValidations
  end

  after_destroy do |this_points_type|
    first_type = PointsType.all.first
    Event.all.find_each do |this_event|
      if this_event.points_type_id == this_points_type.id
        this_event.points_type_id = first_type.id
        this_event.save!
      end
    end
    UserScore.where(points_type_id: this_points_type.id).delete_all
  end
end
