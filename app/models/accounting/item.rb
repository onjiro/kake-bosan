class Accounting::Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :accounting/type
  attr_accessible :deleted_at, :description, :name
end
