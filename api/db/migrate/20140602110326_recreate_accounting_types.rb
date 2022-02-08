class RecreateAccountingTypes < ActiveRecord::Migration[4.2]
  def change
    drop_table :accounting_types
    create_table :accounting_types do |t|
      t.string :name
      t.references :side
      t.timestamp :deleted_at

      t.timestamps
    end
    add_index :accounting_types, :side_id
  end
end
