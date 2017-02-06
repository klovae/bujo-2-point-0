class RemovePastMigrationFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :past_migration
  end
end
