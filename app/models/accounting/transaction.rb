class Accounting::Transaction < ActiveRecord::Base
  belongs_to :user
  has_many :entries, class_name: 'Accounting::Entry', dependent: :delete_all
  accepts_nested_attributes_for :entries

  before_save :remove_empty_entry, unless: 'entries.nil?'

  def self.find_by_terms(user_id, from: Date.today, to: Date.today.next)
    result = self
      .where(user_id: user_id)
      .includes(entries: [:item])
      .joins(entries: [:item])
    result = result.where('date >= ?', from) if from
    result = result.where('date <= ?', to) if to
    result
  end

  private
  def remove_empty_entry
    return unless self.entries
    self.entries.each do |entry|
      entry.mark_for_destruction if entry.amount.nil? || entry.amount == 0
    end
  end
end
