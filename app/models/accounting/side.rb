class Accounting::Side < ActiveRecord::Base
  self.primary_key = :id

  attr_accessible :deleted_at, :name
end
