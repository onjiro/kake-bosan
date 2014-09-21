#= require angular/models/transaction

angular.module('kake-bosan').service 'Transaction.recents', [
  'Transaction',
  (Transaction) ->
    Transaction.recents = Transaction.query
      from: new Date()
      to:   new Date()
]
