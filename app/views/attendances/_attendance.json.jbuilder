json.extract! attendance, :id, :event_id, :member_id, :date_log, :event_name, :created_at, :updated_at
json.url attendance_url(attendance, format: :json)
