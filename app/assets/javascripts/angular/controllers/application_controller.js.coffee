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
  $scope.addNewTransaction = () ->
    return unless $scope.newTransaction.validate()
    $scope.newTransaction.submitting = true
    document.body.style.cursor = 'wait'
    $scope.newTransaction.$save(
      (data, res) ->
        transactions.push new Transaction($scope.newTransaction)
        $scope.newTransaction = Transaction.template($scope.newTransaction)
        document.body.style.cursor = 'auto'
      (err) ->
        alert "#{err.status}: #{err.statusText}"
        delete $scope.newTransaction.submitting
        document.body.style.cursor = 'auto'
    )

  $scope.remove = (transaction) ->
    return unless confirm "本当に削除してよろしいですか？"
    transaction.$remove(
      (data, res) -> transactions.splice(transactions.indexOf(transaction), 1)
      (err) -> alert "#{err.status}: #{err.statusText}"
    )

  $scope.itemName = (item_id) -> _.findWhere($scope.items, {id: item_id}).name
]
