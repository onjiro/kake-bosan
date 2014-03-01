class CreateAccountingSides < ActiveRecord::Migration
  def change
    create_table :accounting_sides do |t|
      t.string :name
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
