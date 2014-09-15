class InventorySetting < ActiveRecord::Base
  belongs_to :user
  belongs_to :debit_item , class_name: 'Accounting::Item'
  belongs_to :credit_item, class_name: 'Accounting::Item'
end
