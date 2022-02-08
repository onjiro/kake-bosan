class CreateAccountingTypes < ActiveRecord::Migration[4.2]
  def change
    create_table :accounting_types do |t|
      t.string :name
      t.references :accounting_side
      t.timestamp :deleted_at

      t.timestamps
    end
    add_index :accounting_types, :accounting_side_id
  end
end
