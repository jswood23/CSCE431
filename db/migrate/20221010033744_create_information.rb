class CreateInformation < ActiveRecord::Migration[6.1]
  def change
    create_table :information do |t|
      t.integer :user_id
      t.string :position
      t.string :bios
      t.string :phone
      t.integer :points
      t.boolean :private

      t.timestamps
    end
  end
end
