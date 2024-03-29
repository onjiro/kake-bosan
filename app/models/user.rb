class User < ApplicationRecord
  has_one :inventory_setting
  has_many :items, class_name: "Accounting::Item"
  has_many :transactions, class_name: "Accounting::Transaction"

  validates :provider, presence: :true
  validates :uid, presence: :true
  validates :name, presence: :true

  validates_uniqueness_of :uid, scope: :provider

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]

      if user.provider != "twitter"
        user.name = auth["info"]["name"]
      else
        user.name = auth["info"]["nickname"]
      end
    end
  end
end
