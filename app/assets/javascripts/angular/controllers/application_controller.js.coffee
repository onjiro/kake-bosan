#= require angular/modules/kake-bosan
#= require angular/models/transaction
#= require angular/models/item

user_id = 0
accounting_side_credit = 1
accounting_side_debit  = 2

angular.module('kake-bosan').controller 'AppController', ['$scope', '$http', 'Transaction', 'Item', ($scope, $http, Transaction, Item) ->
  $scope.items = Item.query()
  transactions = $scope.transactions = Transaction.query()

  $scope.newTransaction = Transaction.template()

  # entry form
  $scope.onEntry = false
  $scope.toggleEntryForm = () -> $scope.onEntry = !$scope.onEntry
  $scope.addNewTransaction = () ->
    this.toggleEntryForm()
    $scope.newTransaction.$save (data, res) ->
      transactions.push new Transaction(data)
      $scope.newTransaction = Transaction.template(data)
]
