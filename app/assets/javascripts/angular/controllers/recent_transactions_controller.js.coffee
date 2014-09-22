#= require angular/modules/kake-bosan
#= require angular/models/transaction_recents

angular.module('kake-bosan').controller 'RecentTransactionsController', [
  '$scope',
  'Transaction'
  'Transaction.recents'
  ($scope, Transaction) ->
    # properties
    newTransactions = $scope.newTransactions = []
    recents = $scope.recents = Transaction.recents

    # relation from other controllers
    $scope.$on 'Transaction::new', (e, transaction) -> newTransactions.push(transaction)

    # actions
]
