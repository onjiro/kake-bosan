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

    Accounting::Entry
      .where(e[:user_id].eq(user_id).and trx[:date].lt(date))
      .joins(:transaction_belongs_to, item: [:type])
      .select(e[:item_id], type[:side_id], <<-EOD_AMOUNT)
          SUM(
            CASE WHEN accounting_entries.side_id = accounting_types.side_id
              THEN  accounting_entries.amount
              ELSE -accounting_entries.amount
            END
          ) AS amount
        EOD_AMOUNT
      .group(:item_id)
  end
end
