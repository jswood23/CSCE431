class AddPointsTypeToEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :points_type_id, :integer
  end
end
