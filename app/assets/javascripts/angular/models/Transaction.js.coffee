#= require angular/modules/kake-bosan
#= require underscore

angular.module('kake-bosan').factory 'Transaction', ['$resource', ($resource) ->
  Transaction = $resource '/accounting/transactions/:id.json',
    id: '@id',

  # 入力用のテンプレート設定済みトランザクションを生成する
  Transaction.template = (src) ->
    new Transaction
      date: new Date(src?.date || Date()),
      entries_attributes: [
        {
          side_id: 2, # Credit
          item_id: src?.entries?[0]?.item_id || 0,
          amount: null,
        },
        {
          side_id: 1, # Debit
          item_id: src?.entries?[1]?.item_id || 0,
          amount: null,
        },
      ]

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
