json.extract! event, :id, :event_name, :description, :passcode, :date, :points, :created_at, :updated_at
json.url event_url(event, format: :json)