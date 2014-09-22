class RecreateIndexOnTransactions < ActiveRecord::Migration
  def change
    remove_index :accounting_transactions, :user_id
    add_index :accounting_transactions, [:user_id, :date]
  end
end
