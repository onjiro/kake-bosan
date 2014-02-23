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
    $http.post '/transaction', newTransaction =
        datetime: newTransactionEntry.datetime
        amount:   newTransactionEntry.amount
        getSummaryAccount: () -> "account summary"
        getAmount: () -> this.amount
    .success (data) ->
      transactions.push newTransaction
    .error (data, status) ->
      # TODO エラー処理についてはまた改めて検討する
      console.error data
    this.onEntry = false
