class RecreateIndexOnTransactions < ActiveRecord::Migration[4.2]
  def change
    remove_index :accounting_transactions, :user_id
    add_index :accounting_transactions, [:user_id, :date]
  end
end
