class Accounting::Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :type
end