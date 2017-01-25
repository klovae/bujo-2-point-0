class AddPastMigrationToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :past_migration, :boolean
  end
end
