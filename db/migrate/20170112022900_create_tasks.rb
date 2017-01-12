class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :content
      t.string :status
      t.integer :day_id
      t.timestamps
    end
  end
end
