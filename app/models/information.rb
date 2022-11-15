# frozen_string_literal: true

class Information < ApplicationRecord
  belongs_to :user, optional: true

  after_create do |info|
    info.points = 0
    info.position = 'User'
    info.start_year = nil
    info.end_year = nil
    info.bios = ''
    info.phone = ''
    info.private = false
  end
end
