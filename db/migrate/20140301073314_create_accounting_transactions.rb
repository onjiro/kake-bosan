class CreateAccountingTransactions < ActiveRecord::Migration
  def change
    create_table :accounting_transactions do |t|
      t.references :user
      t.timestamp :date
      t.string :description

      t.timestamps
    end
    add_index :accounting_transactions, :user_id
  end
end
