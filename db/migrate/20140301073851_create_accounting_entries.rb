class CreateAccountingEntries < ActiveRecord::Migration
  def change
    create_table :accounting_entries do |t|
      t.references :user
      t.references :accounting/side
      t.references :accounting/item
      t.integer :amount

      t.timestamps
    end
    add_index :accounting_entries, :user_id
    add_index :accounting_entries, :accounting/side_id
    add_index :accounting_entries, :accounting/item_id
  end
end
