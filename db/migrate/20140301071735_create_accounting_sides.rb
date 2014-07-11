class CreateAccountingSides < ActiveRecord::Migration
  def change
    create_table :accounting_sides, id: false do |t|
      t.integer :id, :options => 'PRIMARY KEY'
      t.string :name
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
