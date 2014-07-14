class Accounting::Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :transaction_belongs_to, class_name: 'Accounting::Transaction', foreign_key: 'transaction_id'
  belongs_to :side, class_name: 'Accounting::Side'
  belongs_to :item, class_name: 'Accounting::Item'
end
