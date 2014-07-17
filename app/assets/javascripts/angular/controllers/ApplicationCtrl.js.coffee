#= require angular/modules/kake-bosan
#= require angular/models/Transaction
#= require angular/models/item

user_id = 0
accounting_side_credit = 1
accounting_side_debit  = 2

angular.module('kake-bosan').controller 'AppController', ['$scope', '$http', 'Transaction', 'Item', ($scope, $http, Transaction, Item) ->
  $scope.items = Item.query()
  transactions = $scope.transactions = Transaction.query()

  newTransactionEntry = $scope.newTransactionEntry =
    datetime: new Date()
    amount: null
    debitAccount: 0
    creditAccount: 0

  # entry form
  $scope.onEntry = false
  $scope.toggleEntryForm = () -> $scope.onEntry = !$scope.onEntry
  $scope.addNewTransaction = () ->
    this.toggleEntryForm()
    $http.post '/accounting/transactions.json', data =
      transaction:
        date: newTransactionEntry.datetime
        entries_attributes:  [
          {
            side_id: accounting_side_debit
            item_id: newTransactionEntry.debitAccount
            amount: newTransactionEntry.amount
          }
          {
            side_id: accounting_side_credit
            item_id: newTransactionEntry.creditAccount
            amount: newTransactionEntry.amount
          }
        ]
    .success (data) ->
      transactions.push new Transaction(data)
    .error (data, status) ->
      # TODO エラー処理についてはまた改めて検討する
      console.error data
]
