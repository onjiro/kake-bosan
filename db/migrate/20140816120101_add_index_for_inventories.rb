class AddIndexForInventories < ActiveRecord::Migration[4.2]
  def change
    add_index :accounting_entries, [:user_id, :item_id, :side_id]
    add_index :accounting_transactions, :date
  end
end
