#= require angular/modules/kake-bosan

angular.module('kake-bosan').factory 'Transaction', ['$resource', ($resource) ->
  Transaction = $resource '/accounting/transactions/:id.json',
    id: '@id',

  Transaction.prototype.getSummaryAccount = () ->
    this.creditEntries()[0]?.item?.name
  Transaction.prototype.getAmount = () ->
    this.debitEntries().reduce ((sum, entry) -> sum + entry.amount), 0
  Transaction.prototype.debitEntries = () ->
    this.entries = [] unless this.entries
    this.entries.filter (entry) -> entry.side_id == 1
  Transaction.prototype.creditEntries = () ->
    this.entries = [] unless this.entries
    this.entries.filter (entry) -> entry.side_id == 2

  return Transaction
]
