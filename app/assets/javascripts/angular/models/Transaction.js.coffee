class @Transaction
  constructor: (options) ->
    {@user_id, @date, @entries} = options

  getSummaryAccount: () -> "account summary"
  getAmount: () -> this.debitEntries().reduce(((sum, entry) -> sum + entry.amount), 0)
  debitEntries: () -> @entries.filter (entry) -> entry.side_id == 1
