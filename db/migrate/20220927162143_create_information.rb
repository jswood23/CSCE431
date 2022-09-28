class CreateInformation < ActiveRecord::Migration[6.1]
  def change
    create_table :information do |t|
      t.integer :uid
      t.string :name
      t.string :email
      t.string :position
      t.text :bios
      t.string :phone
      t.integer :points

      t.timestamps
    end
  end
end
