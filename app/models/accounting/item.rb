class Accounting::Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :type
  attr_accessible :deleted_at, :description, :name
end
