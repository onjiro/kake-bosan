class Accounting::Transaction < ActiveRecord::Base
  belongs_to :user
  has_many :entries, class_name: 'Accounting::Entry'
  accepts_nested_attributes_for :entries
end
