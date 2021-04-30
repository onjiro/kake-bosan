class ChangeDefaultValue < ActiveRecord::Migration[4.2]
  def change
    change_column :accounting_items, :selectable, :boolean, null: false, default: true
  end
end
