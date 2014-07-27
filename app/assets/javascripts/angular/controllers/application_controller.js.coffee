#= require angular/modules/kake-bosan
#= require angular/models/transaction
#= require angular/models/item

angular.module('kake-bosan').controller 'AppController', ['$scope', '$element', '$timeout', 'Transaction', 'Item', ($scope, $element, $timeout, Transaction, Item) ->
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
