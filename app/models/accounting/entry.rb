class Accounting::Entry < ApplicationRecord
  belongs_to :user
  belongs_to :transaction_belongs_to, class_name: "Accounting::Transaction", foreign_key: "transaction_id"
  belongs_to :side, class_name: "Accounting::Side"
  belongs_to :item, class_name: "Accounting::Item"

  scope :belonging, -> (user_id) { where(user_id: user_id) }
  scope :debits, -> { where(side: Accounting::Side::DEBIT) }
  scope :credits, -> { where(side: Accounting::Side::CREDIT) }
  scope :at, -> (range) { joins(:transaction_belongs_to).where(transaction_belongs_to: { date: range }) }
  scope :sum_by_items, -> () do
    joins(item: [:type])
      .group(:item_id)
      .sum(<<~EOF)
        CASE
          WHEN accounting_entries.side_id = accounting_types.side_id
          THEN amount
          ELSE -amount
        END
      EOF
  end

  def self.summaries(user_id, date_from, date_to)
    amounts = Accounting::Entry.belonging(user_id).at((date_from.beginning_of_day)...(date_to.end_of_day)).sum_by_items
    Accounting::Item.includes(:type).where(user_id: user_id).map { |item| Accounting::Inventory.new(item, amounts[item.id] || 0) }
  end

  # 指定日付以前のユーザーの棚卸額を科目ごとに集計します
  def self.inventories(user_id, date)
    amounts = Accounting::Entry.belonging(user_id).at(...(date.end_of_day)).sum_by_items
    Accounting::Item.includes(:type).where(user_id: user_id).map { |item| Accounting::Inventory.new(item, amounts[item.id] || 0) }
  end

  def self.inventory(item_id, user_id, date)
    amount = Accounting::Entry.belonging(user_id).at(...(date.end_of_day)).where(item_id: item_id).sum_by_items[item_id.to_i]
    Accounting::Inventory.new(Accounting::Item.find(item_id), amount || 0)
  end

  def self.take_inventory(item_id, user_id, date, amount_to_be)
    item = User.find(user_id).items.find(item_id)

    inventory = self.inventory(item_id, user_id, date)
    entry_amount = amount_to_be - inventory.amount
    return inventory if entry_amount == 0

    entry_side = (entry_amount > 0) ? item.type.side : item.type.side.flip
    opposite_account_item = Accounting::Item.inventory_fix_item_for(user_id, entry_side.flip)

    Accounting::Transaction.create! user_id: user_id, date: date, entries_attributes: [
      { user_id: user_id, side_id: entry_side.id, item_id: item.id, amount: entry_amount.abs },
      { user_id: user_id, side_id: entry_side.flip.id, item_id: opposite_account_item.id, amount: entry_amount.abs },
    ]

    Accounting::Inventory.new(item, amount_to_be)
  end
end
