class ChangeDeletedAtToSelectable < ActiveRecord::Migration
  def change
    remove_column :accounting_items, :deleted_at
    add_column :accounting_items, :selectable, :boolean, null: false, default: false
  end
end
