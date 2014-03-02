class CreateAccountingEntries < ActiveRecord::Migration
  def change
    create_table :accounting_entries do |t|
      t.references :user
      t.references :accounting_side
      t.references :accounting_item
      t.integer :amount

      t.timestamps
    end
    add_index :accounting_entries, :user_id
    add_index :accounting_entries, :accounting_side_id
    add_index :accounting_entries, :accounting_item_id
  end
end
