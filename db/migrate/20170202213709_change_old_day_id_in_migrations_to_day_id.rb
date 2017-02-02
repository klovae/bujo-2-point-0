class ChangeOldDayIdInMigrationsToDayId < ActiveRecord::Migration[5.0]
  def change
    rename_column :migrations, :old_day_id, :day_id
  end
end
