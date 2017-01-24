class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :content
      t.string :status
      t.integer :day_id
      t.integer :user_id
    end
  end
end
