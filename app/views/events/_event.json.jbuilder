# frozen_string_literal: true

json.extract!(event, :id, :event_name, :description, :passcode, :date, :points_type_id, :points, :created_at, :updated_at)
json.url(event_url(event, format: :json))
