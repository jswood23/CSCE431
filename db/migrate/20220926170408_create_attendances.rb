class CreateAttendances < ActiveRecord::Migration[6.1]
  def change
    create_table :attendances do |t|
      t.integer :event_id
      t.integer :member_id
      t.date :date_log
      t.string :event_name

      t.timestamps
    end
  end
end
