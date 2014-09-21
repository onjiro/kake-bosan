#= require angular/modules/kake-bosan
#= require angular/models/transaction
#= require angular/models/item
#= require underscore

angular.module('kake-bosan').controller 'AppController', [
  '$scope',
  '$rootScope',
  'Transaction',
  'Item',
  ($scope, $rootScope, Transaction, Item) ->
    $scope.types = [
      { id: 1, name: "資産", side_id: 1 },
      { id: 2, name: "費用", side_id: 1 },
      { id: 3, name: "負債", side_id: 2 },
      { id: 4, name: "資本", side_id: 2 },
      { id: 5, name: "収益", side_id: 2 },
    ]
    $scope.items = Item.query()

    $scope.newTransaction = Transaction.template()
    $scope.formattedNewTransaction = $scope.newTransaction.toDisplayFormat()

    $scope.amountLinked = true
    $scope.$watch 'formattedNewTransaction.rows.length', (newValue, oldValue) ->
      $scope.amountLinked = (newValue == 1)

    # entry form
    $scope.addNewTransaction = () ->
      return unless $scope.newTransaction.validate()
      $scope.newTransaction.submitting = true
      $scope.newTransaction.$save(
        (data, res) ->
          $rootScope.$broadcast 'Transaction::new', new Transaction($scope.newTransaction)
          $scope.newTransaction = Transaction.template($scope.newTransaction)
          $scope.formattedNewTransaction = $scope.newTransaction.toDisplayFormat()
        (err) ->
          alert "#{err.status}: #{err.statusText}"
      ).finally () -> delete $scope.newTransaction.submitting

    $scope.remove = (transaction) ->
      return unless confirm "本当に削除してよろしいですか？"
      transaction.$remove(
        (data, res) -> $scope.transactions.splice(transactions.indexOf(transaction), 1)
        (err) -> alert "#{err.status}: #{err.statusText}"
      )
]
