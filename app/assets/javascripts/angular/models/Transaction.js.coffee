class @Transaction
  constructor: (options) ->
    {@user_id, @date, @entries} = options

  getSummaryAccount: () -> "account summary"
  getAmount: () -> 0
