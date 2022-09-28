class CreatePermissions < ActiveRecord::Migration[6.1]
  def change
    create_table :permissions do |t|
      t.integer :uid
      t.boolean :admin
      t.boolean :member
      t.boolean :alumni

      t.timestamps
    end
  end
end
