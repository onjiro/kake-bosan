#= require angular/modules/kake-bosan
#= require angular/models/transaction
#= require angular/models/transaction_history

angular.module('kake-bosan').controller 'HistoryController', [
  '$scope', 'TransactionHistory'
  ($scope, TransactionHistory) ->
    # properties
    history = $scope.history = new TransactionHistory({ days: 30 })
    transactions = $scope.transactions = history.transactions

    # relation from other controllers
    $scope.$on 'Transaction::new', (event, newone) ->
      ransactions.push(newone)
    $scope.$on 'Transaction::remove', (event, transaction) ->
      transactions.splice(transactions.indexOf(transaction), 1)

    # actions
    $scope.loadNextTransactions = () -> history.loadInNextTerm()
]
