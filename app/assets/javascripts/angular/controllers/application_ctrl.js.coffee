#= require angular/modules/kake-bosan
#= require angular/models/transaction
#= require angular/models/item

user_id = 0
accounting_side_credit = 1
accounting_side_debit  = 2

angular.module('kake-bosan').controller 'AppController', ['$scope', '$http', 'Transaction', 'Item', ($scope, $http, Transaction, Item) ->
  $scope.items = Item.query()
  transactions = $scope.transactions = Transaction.query()

  newTransaction = $scope.newTransaction = new Transaction
    date: new Date(),
    entries_attributes: [
      {
        side_id: 2, # Credit
        item_id: 0,
        amount: 0,
      },
      {
        side_id: 1, # Debit
        item_id: 0,
        amount: 0,
      },
    ]

  # entry form
  $scope.onEntry = false
  $scope.toggleEntryForm = () -> $scope.onEntry = !$scope.onEntry
  $scope.addNewTransaction = () ->
    this.toggleEntryForm()
    newTransaction.$save (data, res) ->
      transactions.push new Transaction(data)
      $scope.newTransaction = new Transaction
        date: new Date(),
        entries_attributes: [
          {
            side_id: 1, # Debit
            item_id: 0,
            amount: 0,
          },
          {
            side_id: 2, # Credit
            item_id: 0,
            amount: 0,
          },
        ]
]
