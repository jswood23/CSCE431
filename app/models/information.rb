# frozen_string_literal: true

class Information < ApplicationRecord
  belongs_to :user, optional: true

  after_create do |info|
    info.points = 0
    info.position = 'User'
    info.bios = ''
    info.phone = ''
    info.private = false
  end
end
