class Accounting::Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :transaction, class_name: 'Accounting::Transaction'
  belongs_to :side, class_name: 'Accounting::Side'
  belongs_to :item, class_name: 'Accounting::Item'
  attr_accessor :user_id, :side_id, :item_id, :amount
end
