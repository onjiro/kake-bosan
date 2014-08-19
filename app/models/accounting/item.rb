class Accounting::Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :type

  def self.inventory_fix_item_for(user_id, side)
    return self.new(id: 0)
  end
end
