#= require angular/modules/kake-bosan
#= require angular/models/transaction

angular.module('kake-bosan').controller 'EntryFormController', [
  '$scope', '$rootScope', 'Transaction',
  ($scope, $rootScope, Transaction) ->
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
]
