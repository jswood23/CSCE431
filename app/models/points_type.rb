# frozen_string_literal: true

include ApplicationHelper

class PointsType < ApplicationRecord
  after_create do |this_user|
    create_all_user_scores
  end

  after_update do |this_user|
    create_all_user_scores
  end
end
