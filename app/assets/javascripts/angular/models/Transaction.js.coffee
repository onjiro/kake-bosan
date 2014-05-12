class @Transaction
  constructor: (options) ->
    {@user_id, @date, @entries} = options

  getSummaryAccount: () -> "account summary"
  getAmount: () -> this.debitEntries().reduce(((entry, sum) -> 0 + entry.amount), 0)
  debitEntries: () -> [] # todo
