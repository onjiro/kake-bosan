window.appController = ($scope) ->
  $scope.onEntry = false
  $scope.toggleEntryForm = () -> $scope.onEntry = !$scope.onEntry
