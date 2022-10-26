class CreateUserScores < ActiveRecord::Migration[6.1]
  def change
    create_table :user_scores, primary_key: [:user_id, :points_type_id] do |t|
      t.bigint :user_id
      t.bigint :points_type_id
      t.string :points_type_name
      t.integer :score

      t.timestamps
    end
  end
end
