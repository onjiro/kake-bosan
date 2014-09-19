class CreateInventorySettings < ActiveRecord::Migration
  def change
    create_table :inventory_settings, id: false do |t|
      t.column     :user_id, 'INTEGER PRIMARY KEY'
      t.references :debit_item , null: false
      t.references :credit_item, null: false

      t.timestamps
    end
  end
end
