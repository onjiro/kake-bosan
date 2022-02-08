class Accounting::Type < ApplicationRecord
  belongs_to :side

  ASSET     = Accounting::Type.new(id: 1, side: Accounting::Side::DEBIT, name: '資産')
  EXPENSE   = Accounting::Type.new(id: 2, side: Accounting::Side::DEBIT, name: '費用')
  LIABILITY = Accounting::Type.new(id: 3, side: Accounting::Side::CREDIT, name: '負債')
  CAPITAL   = Accounting::Type.new(id: 4, side: Accounting::Side::CREDIT, name: '資本')
  INCOME    = Accounting::Type.new(id: 5, side: Accounting::Side::CREDIT, name: '収益')
end
