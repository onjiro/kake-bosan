import "../modules/kake-bosan"

angular.module('kake-bosan').service 'Type', ['$resource', ($resource) ->
  this.ASSET     = { id: 1, side: 1, name: '資産' }
  this.EXPENSE   = { id: 2, side: 1, name: '費用' }
  this.LIABILITY = { id: 3, side: 2, name: '負債' }
  this.CAPITAL   = { id: 4, side: 2, name: '資本' }
  this.INCOME    = { id: 5, side: 2, name: '収益' }
  this.all = [this.ASSET, this.EXPENSE, this.LIABILITY, this.CAPITAL, this.INCOME]
  return this
]
