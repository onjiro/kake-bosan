class Accounting::Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :accounting_side
  belongs_to :accounting_item
  attr_accessible :amount
end
