class CreateAccountingTypes < ActiveRecord::Migration
  def change
    create_table :accounting_types do |t|
      t.string :name
      t.references :accounting/side
      t.timestamp :deleted_at

      t.timestamps
    end
    add_index :accounting_types, :accounting/side_id
  end
end
