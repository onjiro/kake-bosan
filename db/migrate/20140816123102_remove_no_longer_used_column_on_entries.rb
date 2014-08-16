class RemoveNoLongerUsedColumnOnEntries < ActiveRecord::Migration
  def change
    remove_column :accounting_entries, :entry_id
  end
end
