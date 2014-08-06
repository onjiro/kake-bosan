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

  Transaction.prototype.getSummaryAccount = () ->
    this.debitEntries()[0]?.item?.name
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

  Transaction.prototype.validate = () ->
    sum = _.reduce(
      this.debitEntries(),
      (memo, each) -> if each.amount then memo + each.amount else memo
      0
    )
    return sum > 0

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
