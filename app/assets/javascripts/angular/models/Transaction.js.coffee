#= require angular/modules/kake-bosan

angular.module('kake-bosan').factory 'Transaction', ['$resource', ($resource) ->
  Transaction = $resource '/accounting/transactions/:id.json', {
    id: '@id',
    user_id: null,
    date: null,
    entries: [],
  }

  Transaction.prototype.getSummaryAccount = () -> "account summary"
  Transaction.prototype.getAmount = () ->
    this.debitEntries().reduce(((sum, entry) -> sum + entry.amount), 0)
  Transaction.prototype.debitEntries = () ->
    this.entries = [] unless this.entries
    this.entries.filter (entry) -> entry.side_id == 1

  return Transaction
]
