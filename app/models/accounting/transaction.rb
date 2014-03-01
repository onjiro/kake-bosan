class Accounting::Transaction < ActiveRecord::Base
  belongs_to :user
  attr_accessible :date, :description
end
