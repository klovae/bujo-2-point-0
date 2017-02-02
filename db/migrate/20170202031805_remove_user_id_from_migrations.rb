class RemoveUserIdFromMigrations < ActiveRecord::Migration[5.0]
  def change
    remove_column :migrations, :user_id
  end
end
