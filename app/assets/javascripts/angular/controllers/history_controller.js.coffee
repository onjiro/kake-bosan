#= require angular/modules/kake-bosan
#= require angular/models/transaction
#= require angular/models/transaction_recents

angular.module('kake-bosan').controller 'HistoryController', [
  '$scope', 'Transaction', 'Transaction.recents'
  ($scope, Transaction) ->
    # properties
    transactions = $scope.transactions = Transaction.recents

    # relation from other controllers
    $scope.$on 'Transaction::new', (event, newone) ->
      transactions.push(newone)
    $scope.$on 'Transaction::remove', (event, transaction) ->
      transactions.splice(transactions.indexOf(transaction), 1)

    # actions
    $scope.loadNextTransactions = () ->
      transactions.loadAdditionals({ day: 7 })
]
