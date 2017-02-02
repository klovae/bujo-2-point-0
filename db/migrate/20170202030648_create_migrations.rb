class CreateMigrations < ActiveRecord::Migration[5.0]
  def change
    create_table :migrations do |t|
      t.integer :old_day_id
      t.integer :new_day_id
      t.integer :user_id
      t.integer :task_id
      t.timestamps
    end
  end
end
