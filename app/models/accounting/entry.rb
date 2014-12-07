class Accounting::Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :transaction_belongs_to, class_name: 'Accounting::Transaction', foreign_key: 'transaction_id'
  belongs_to :side, class_name: 'Accounting::Side'
  belongs_to :item, class_name: 'Accounting::Item'

  # 指定期間のユーザーの移動額を科目ごとに集計します
  def self.summaries(user_id, from, to)
    e = Accounting::Entry.arel_table
    trx = Accounting::Transaction.arel_table
    type = Accounting::Type.arel_table
    i = Accounting::Item.arel_table

    return Accounting::Item
      .joins(:type, entry: [:transaction_belongs_to],)
      .where(i[:user_id].eq(user_id).and trx[:date].in(from..to))
      .select(i[:id].as('item_id'), type[:side_id], i[:description], <<-EOD_AMOUNT, i[:selectable])
          COALESCE(SUM(
            CASE WHEN accounting_entries.side_id = accounting_types.side_id
              THEN  accounting_entries.amount
              ELSE -accounting_entries.amount
            END
          ), 0) AS amount
        EOD_AMOUNT
      .group(i[:id], type[:side_id])
  end

  # 指定日付以前のユーザーの棚卸額を科目ごとに集計します
  def self.inventories(user_id, date)
    e = Accounting::Entry.arel_table
    trx = Accounting::Transaction.arel_table
    type = Accounting::Type.arel_table
    i = Accounting::Item.arel_table

    all_items = Accounting::Item
      .joins(:type)
      .where(user_id: user_id)
      .select(i[:id].as('item_id'), i[:name], type[:side_id], i[:description], i[:selectable], '0 AS amount')

    amount_by_item = Accounting::Item
      .joins(:type, entry: [:transaction_belongs_to])
      .where(i[:user_id].eq(user_id).and trx[:date].lt(date))
      .select(i[:id], <<-EOD_AMOUNT)
          COALESCE(SUM(
            CASE WHEN accounting_entries.side_id = accounting_types.side_id
              THEN  accounting_entries.amount
              ELSE -accounting_entries.amount
            END
          ), 0) AS amount
        EOD_AMOUNT
      .group(i[:id])
      .inject({}) {|hash, i| hash[i.id] = i.amount; hash }

    all_items.each {|item| item.amount = amount_by_item[item.item_id] if amount_by_item.has_key?(item.item_id) }
  end

  def self.inventory(item_id, user_id, date)
    e = Accounting::Entry.arel_table
    trx = Accounting::Transaction.arel_table
    type = Accounting::Type.arel_table
    i = Accounting::Item.arel_table

    return Accounting::Item
      .joins(:type)
      .joins(i
               .join(e, Arel::Nodes::OuterJoin).on(i[:id].eq(e[:item_id]).and e[:user_id].eq(user_id))
               .join(trx, Arel::Nodes::OuterJoin).on(e[:transaction_id].eq(trx[:id]).and trx[:date].lt(date))
               .join_sources
             )
      .where(i[:user_id].eq(user_id).and i[:id].eq(item_id))
      .select(i[:id].as('item_id'), type[:side_id], i[:description], <<-EOD_AMOUNT, i[:selectable])
          COALESCE(SUM(
            CASE WHEN accounting_entries.side_id = accounting_types.side_id
              THEN  accounting_entries.amount
              ELSE -accounting_entries.amount
            END
          ), 0) AS amount
        EOD_AMOUNT
      .group(i[:id], type[:side_id])
      .first
  end

  def self.take_inventory(item_id, user_id, date, amount_to_be)
    item = Accounting::Item
      .where(id: item_id, user_id: user_id)
      .joins(type: [:side])
      .includes(type: [:side])
      .first
    raise Exception.new("No item found for item_id: #{item_id}") unless item

    inventory = self.inventory(item_id, user_id, date)
    entry_amount = amount_to_be - inventory.amount
    return inventory if entry_amount == 0

    entry_side = (entry_amount > 0) ? item.type.side: item.type.side.flip
    opposite_account_item = Accounting::Item.inventory_fix_item_for(user_id, entry_side.flip)

    Accounting::Transaction.create user_id: user_id, date: date, entries_attributes:
      [
        {
          user_id: user_id,
          side_id: entry_side.id,
          item_id: item.id,
          amount:  entry_amount.abs
        },
        {
          user_id: user_id,
          side_id: entry_side.flip.id,
          item_id: opposite_account_item.id,
          amount:  entry_amount.abs
        },
      ]

    inventory.amount = amount_to_be
    return inventory
  end
end
