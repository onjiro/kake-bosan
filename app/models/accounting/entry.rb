class Accounting::Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :transaction_belongs_to, class_name: 'Accounting::Transaction', foreign_key: 'transaction_id'
  belongs_to :side, class_name: 'Accounting::Side'
  belongs_to :item, class_name: 'Accounting::Item'

  # 指定日付以前のユーザーの棚卸額を科目ごとに集計します
  def self.inventories(user_id, date)
    e = Accounting::Entry.arel_table
    t = Accounting::Transaction.arel_table
    Accounting::Entry
      .where(e[:user_id].eq(user_id).and(t[:date].lt(date)))
      .joins(:transaction_belongs_to)
      .select(e[:side_id], e[:item_id], e[:amount].sum.as('amount'))
      .group([:side_id, :item_id])
  end
end
