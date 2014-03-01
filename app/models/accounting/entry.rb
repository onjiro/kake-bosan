class Accounting::Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :accounting/side
  belongs_to :accounting/item
  attr_accessible :amount
end
