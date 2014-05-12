# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
accounting_sides = Accounting::Side.create([
  {id: 1, name: "debit" , deleted_at: nil},
  {id: 2, name: "credit", deleted_at: nil},
], without_protection: true)
