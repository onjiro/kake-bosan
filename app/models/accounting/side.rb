class Accounting::Side < ActiveRecord::Base
  self.primary_key = :id

  DEBIT  = Accounting::Side.new({id: 1, name: '借方'}, without_protection: true)
  CREDIT = Accounting::Side.new({id: 2, name: '貸方'}, without_protection: true)
end
