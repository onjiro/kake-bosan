#= require angular/modules/kake-bosan
#= require angular/models/transaction
#= require angular/models/item
#= require underscore

angular.module('kake-bosan').controller 'AppController', ['$scope', '$element', '$timeout', 'Transaction', 'Item', ($scope, $element, $timeout, Transaction, Item) ->
  $scope.types = [
    { id: 1, name: "資産", side_id: 1 },
    { id: 2, name: "費用", side_id: 1 },
    { id: 3, name: "負債", side_id: 2 },
    { id: 4, name: "資本", side_id: 2 },
    { id: 5, name: "収益", side_id: 2 },
  ]
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
