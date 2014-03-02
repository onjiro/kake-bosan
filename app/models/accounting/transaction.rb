class Accounting::Transaction < ActiveRecord::Base
  belongs_to :user
  has_many :accounting_entry
  attr_accessible :date, :description
end
