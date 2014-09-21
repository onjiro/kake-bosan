#= require angular/modules/kake-bosan
#= require angular/models/transaction

angular.module('kake-bosan').controller 'HistoryController', [
  '$scope',
  'Transaction',
  (
    $scope,
    Transaction
  ) ->
    transactions = $scope.transactions = Transaction.query()

    $scope.$on 'Transaction::new', (event, newone) ->
      transactions.push(newone)
]
