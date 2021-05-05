#= require angular/modules/kake-bosan
#= require angular/models/transaction_history

angular.module('kake-bosan').controller 'RecentTransactionsController', [
  '$scope', 'TransactionHistory',
  ($scope, TransactionHistory) ->
    # properties
    newTransactions = $scope.newTransactions = []
    history = $scope.history = new TransactionHistory({ days: 7 })
    recents = $scope.recents = history.transactions

    # relation from other controllers
    $scope.$on 'Transaction::new', (e, transaction) ->
      newTransactions.push(transaction)
    $scope.$on 'Transaction::remove', (event, transaction) ->
      position = newTransactions.indexOf(transaction)
      newTransactions.splice(position, 1) if position != -1
    $scope.$on 'Transaction::remove', (event, transaction) ->
      position = recents.indexOf(transaction)
      recents.splice(position, 1) if position != -1

    # actions
]
