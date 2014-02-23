window.appController = ($scope) ->
  # entry form
  $scope.onEntry = false
  $scope.toggleEntryForm = () -> $scope.onEntry = !$scope.onEntry
  $scope.addNewTransaction = () ->
    window.alert 'addNewTransaction'
    this.onEntry = false
