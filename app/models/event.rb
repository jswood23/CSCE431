# frozen_string_literal: true

class Event < ApplicationRecord
  validates :event_name, presence: true
  validates :description, presence: true
  validates :passcode, presence: true
  validates :date, presence: true
  validates :points, presence: true

  after_destroy do |this_event|
    AttendanceRecord.where(event_id: this_event.id).delete_all
  end
end
