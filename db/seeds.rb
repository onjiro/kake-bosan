# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Accounting::Side.delete_all()
Accounting::Side::DEBIT.save()
Accounting::Side::CREDIT.save()

Accounting::Type.delete_all()
Accounting::Type::ASSET.save()
Accounting::Type::EXPENSE.save()
Accounting::Type::LIABILITY.save()
Accounting::Type::CAPITAL.save()
Accounting::Type::INCOME.save()
