class CreatePages < ActiveRecord::Migration[6.1]
  def change
    create_table :pages do |t|
      t.integer :pid, :auto_increment
      t.string :page_name
      t.json :page_data

      t.timestamps
    end
  end
end
