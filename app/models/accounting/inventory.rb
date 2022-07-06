class Accounting::Inventory
  include ActiveModel::Serializers::JSON

  attr_accessor :item, :amount

  def initialize(item, amount)
    @item = item
    @amount = amount
  end

  def attributes
    {
      'item' => nil,
      'amount' => amount,
    }
  end
end
