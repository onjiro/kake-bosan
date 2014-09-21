#= require angular/modules/kake-bosan
#= require angular/models/transaction_recents

angular.module('kake-bosan').controller 'RecentTransactionsController', [
  '$scope',
  'Transaction'
  'Transaction.recents'
  ($scope, Transaction) ->
    $scope.recents = Transaction.recents
]
