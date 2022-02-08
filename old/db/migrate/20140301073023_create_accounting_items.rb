class CreateAccountingItems < ActiveRecord::Migration[4.2]
  def change
    create_table :accounting_items do |t|
      t.references :user
      t.string :name
      t.references :accounting_type
      t.string :description
      t.timestamp :deleted_at

      t.timestamps
    end
    add_index :accounting_items, :user_id
    add_index :accounting_items, :accounting_type_id
  end
end
