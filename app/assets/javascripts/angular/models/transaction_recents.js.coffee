#= require angular/models/transaction

angular.module('kake-bosan').service 'Transaction.recents', [
  'Transaction',
  (Transaction) ->
    today = new Date()
    Transaction.recents = Transaction.query
      from: new Date(today.getFullYear(), today.getMonth(), today.getDate() - 6).toLocaleString()
      to:   new Date(today.getFullYear(), today.getMonth(), today.getDate() + 1).toLocaleString()
]
