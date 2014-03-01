class Accounting::Type < ActiveRecord::Base
  belongs_to :accounting/side
  attr_accessible :deleted_at, :name
end
