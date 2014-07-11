class Accounting::Transaction < ActiveRecord::Base
  belongs_to :user
  has_many :entries, class_name: 'Accounting::Entry'
  attr_accessible :user_id, :entries_attributes, :date, :description
  accepts_nested_attributes_for :entries
end
