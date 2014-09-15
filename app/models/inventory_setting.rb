class InventorySetting < ActiveRecord::Base
  self.primary_key = :user_id

  belongs_to :user
  belongs_to :debit_item , class_name: 'Accounting::Item'
  belongs_to :credit_item, class_name: 'Accounting::Item'
end
