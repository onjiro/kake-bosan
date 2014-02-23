window.appController = ($scope) ->
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
    newTransaction =
      datetime: newTransactionEntry.datetime
      amount:   newTransactionEntry.amount
      getSummaryAccount: () -> "account summary"
      getAmount: () -> this.amount
    transactions.push newTransaction
    # TODO post to server
    this.onEntry = false
