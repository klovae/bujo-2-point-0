class RemoveStatusFromEvents < ActiveRecord::Migration[5.0]
  def change
    remove_column :events, :status
  end
end
