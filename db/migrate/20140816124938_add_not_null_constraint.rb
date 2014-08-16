class AddNotNullConstraint < ActiveRecord::Migration
  def change
    change_column_null :users, :provider, false
    change_column_null :users, :uid, false
    change_column_null :accounting_sides, :name, false
    change_column_null :accounting_types, :name, false
    change_column_null :accounting_types, :side_id, false
    change_column_null :accounting_items, :user_id, false
    change_column_null :accounting_items, :name, false
    change_column_null :accounting_items, :type_id, false
    change_column_null :accounting_items, :description, false
    change_column_null :accounting_transactions, :user_id, false
    change_column_null :accounting_transactions, :date, false
    change_column_null :accounting_entries, :user_id, false
    change_column_null :accounting_entries, :transaction_id, false
    change_column_null :accounting_entries, :side_id, false
    change_column_null :accounting_entries, :item_id, false
    change_column_null :accounting_entries, :amount, false

  end
end
