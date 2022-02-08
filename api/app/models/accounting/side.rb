class Accounting::Side < ApplicationRecord
  self.primary_key = :id

  DEBIT  = Accounting::Side.new(id: 1, name: '借方')
  CREDIT = Accounting::Side.new(id: 2, name: '貸方')

  def flip
    self == DEBIT ? CREDIT: DEBIT
  end
end
