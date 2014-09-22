#= require angular/modules/kake-bosan
#= require angular/models/transaction

angular.module('kake-bosan').controller 'HistoryController', [
  '$scope',
  'Transaction',
  (
    $scope,
    Transaction
  ) ->
    # properties
    transactions = $scope.transactions = Transaction.query()

    # relation from other controllers
    $scope.$on 'Transaction::new', (event, newone) ->
      transactions.push(newone)
    $scope.$on 'Transaction::remove', (event, transaction) ->
      transactions.splice(transactions.indexOf(transaction), 1)
]
