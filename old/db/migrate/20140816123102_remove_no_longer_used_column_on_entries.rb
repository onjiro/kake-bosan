class RemoveNoLongerUsedColumnOnEntries < ActiveRecord::Migration[4.2]
  def change
    remove_column :accounting_entries, :entry_id
  end
end
