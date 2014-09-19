class Accounting::Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :type

  def self.inventory_fix_item_for(user_id, side)
    inventory_setting = InventorySetting
      .where(user_id: user_id)
      .includes(:debit_item, :credit_item)
      .joins(:debit_item, :credit_item)
      .first
    return (side == Accounting::Side::CREDIT) ? inventory_setting.credit_item: inventory_setting.debit_item
  end
end
