class Accounting::Type < ActiveRecord::Base
  belongs_to :side

  ASSET     = Accounting::Type.new({id: 1, side: Accounting::Side::DEBIT, name: '資産'}, without_protection: true)
  EXPENSE   = Accounting::Type.new({id: 2, side: Accounting::Side::DEBIT, name: '費用'}, without_protection: true)
  LIABILITY = Accounting::Type.new({id: 3, side: Accounting::Side::CREDIT, name: '負債'}, without_protection: true)
  CAPITAL   = Accounting::Type.new({id: 4, side: Accounting::Side::CREDIT, name: '資本'}, without_protection: true)
  INCOME    = Accounting::Type.new({id: 5, side: Accounting::Side::CREDIT, name: '収益'}, without_protection: true)
end
