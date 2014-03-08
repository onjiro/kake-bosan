user_id = 0
accounting_side_credit = 0
accounting_side_debit  = 1

class Transaction
  constructor: (@user_id, @date, @entries) ->

  getSummaryAccount: () -> "account summary"
  getAmount: () -> 0

window.appController = ($scope, $http) ->
  transactions = $scope.transactions = []
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
        user_id:  user_id
        date: newTransactionEntry.datetime
        entries_attributes:  [
          {
            user_id: user_id
            side_id: accounting_side_debit
            item_id: newTransactionEntry.debitAccount
            amount: newTransactionEntry.amount
          }
          {
            user_id: user_id
            side_id: accounting_side_credit
            item_id: newTransactionEntry.creditAccount
            amount: newTransactionEntry.amount
          }
        ]
    .success (data) ->
      transactions.push new Transaction(data.user_id, data.date, data.entry_attributes)
    .error (data, status) ->
      # TODO エラー処理についてはまた改めて検討する
      console.error data
