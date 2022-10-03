class Event < ApplicationRecord
    validates :event_name, presence: true
    validates :description, presence: true
    validates :date, presence: true
    validates :points, presence: true
    validates :passcode, presence: true
end