class ChangeDefaultValue < ActiveRecord::Migration
  def change
    change_column :accounting_items, :selectable, :boolean, null: false, default: true
  end
end
