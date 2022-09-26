class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.integer :event_id
      t.string :event_name
      t.text :description
      t.date :date
      t.string :passcode

      t.timestamps
    end
  end
end
