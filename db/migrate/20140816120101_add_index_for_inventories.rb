class AddIndexForInventories < ActiveRecord::Migration
  def change
    add_index :accounting_entries, [:user_id, :item_id, :side_id]
    add_index :accounting_transactions, :date
  end
end
