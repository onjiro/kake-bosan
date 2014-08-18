class Accounting::Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :transaction_belongs_to, class_name: 'Accounting::Transaction', foreign_key: 'transaction_id'
  belongs_to :side, class_name: 'Accounting::Side'
  belongs_to :item, class_name: 'Accounting::Item'

  # 指定日付以前のユーザーの棚卸額を科目ごとに集計します
  def self.inventories(user_id, date)
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
      .where(i[:user_id].eq(user_id))
      .select(i[:id].as('item_id'), type[:side_id], <<-EOD_AMOUNT)
          COALESCE(SUM(
            CASE WHEN accounting_entries.side_id = accounting_types.side_id
              THEN  accounting_entries.amount
              ELSE -accounting_entries.amount
            END
          ), 0) AS amount
        EOD_AMOUNT
      .group(i[:id], type[:side_id])
  end
end
