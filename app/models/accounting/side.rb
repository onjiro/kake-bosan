# -*- coding: utf-8 -*-
class Accounting::Side < ActiveRecord::Base
  self.primary_key = :id

  attr_accessible :deleted_at, :name

  DEBIT = Accounting::Side.new({id: 1, name: 'debit'}, without_protection: true)
  CREDIT = Accounting::Side.new({id: 2, name: 'credit'}, without_protection: true)
end
