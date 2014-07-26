class FixAccountingTypeAtReferenceColumnNameOfType < ActiveRecord::Migration
  def change
    rename_column :accounting_items, :accounting_type_id, :type_id
  end
end
