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
          side_id: 1, # Debit
          item_id: src?.debitEntries()[0]?.item_id || 0,
          amount: null,
        },
        {
          side_id: 2, # Credit
          item_id: src?.creditEntries()[0]?.item_id || 0,
          amount: null,
        },
      ]

  Transaction.prototype.getAmount = () ->
    this.debitEntries().reduce ((sum, entry) -> sum + entry.amount), 0

  Transaction.prototype.debitEntries = () ->
    if this.entries
      this.entries.filter (entry) -> entry.side_id == 1
    else
      this.entries_attributes.filter (entry) -> entry.side_id == 1
  Transaction.prototype.creditEntries = () ->
    if this.entries
      this.entries.filter (entry) -> entry.side_id == 2
    else
      this.entries_attributes.filter (entry) -> entry.side_id == 2

  entriesSumFn = (memo, each) -> if each.amount then memo + each.amount else memo
  Transaction.prototype.validate = () ->
    debitSum = _.reduce(this.debitEntries(), entriesSumFn, 0)
    creditSum = _.reduce(this.creditEntries(), entriesSumFn, 0)
    allOfEntriesHaveZeroAmounts = _.reduce(
      this.entries || this.entries_attributes
      (memo, each) -> memo && !each.amount # confirm amount is not undefined/null/0
    )
    return debitSum == creditSum && (not allOfEntriesHaveZeroAmounts)

  Transaction.prototype.addEmptyEntriesPair = () ->
    this.entries_attributes.push
      side_id: 1, # Debit
      item_id: src?.debitEntries()[0]?.item_id || 0,
      amount: null,
    this.entries_attributes.push
      side_id: 2, # Credit
      item_id: src?.creditEntries()[0]?.item_id || 0,
      amount: null,

  # 帳票フォーマットとして表示しやすい形に整える
  Transaction.prototype.toDisplayFormat = () ->
    {
      date: this.date,
      rows: toDisplayFormatRows(this.debitEntries(), this.creditEntries())
    }

  toDisplayFormatRows = (debits, credits) ->
    rowLength = if debits.length < credits.length then credits.length else debits.length
    rows = []
    rows.push {debit: debits[i], credit: credits[i] } for i in [0...rowLength]
    return rows

  return Transaction
]
