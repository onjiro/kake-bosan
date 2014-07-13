class Accounting::Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :type
  attr_accessor :deleted_at, :description, :name
end
