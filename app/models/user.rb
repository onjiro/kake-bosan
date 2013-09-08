class User < ActiveRecord::Base
  attr_accessible :access_token, :email, :image_url, :name, :provider, :uid
end
