class CreateAttendanceRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :attendance_records, primary_key: [:event_id, :uid] do |t|
      t.bigint :event_id
      t.bigint :uid
      t.datetime :date_log
      t.string :event_name
      t.string :member_name

      t.timestamps
    end
  end
end
