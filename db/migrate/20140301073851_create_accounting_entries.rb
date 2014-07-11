class CreateAccountingEntries < ActiveRecord::Migration
  def change
    create_table :accounting_entries do |t|
      t.references :user
      t.references :transaction
      t.references :entry
      t.references :side
      t.references :item
      t.integer :amount

      t.timestamps
    end
    add_index :accounting_entries, :user_id
    add_index :accounting_entries, :transaction_id
    add_index :accounting_entries, :entry_id
    add_index :accounting_entries, :side_id
    add_index :accounting_entries, :item_id
  end
end
