class Accounting::Type < ActiveRecord::Base
  belongs_to :side
  attr_accessible :side_id, :deleted_at, :name
end
