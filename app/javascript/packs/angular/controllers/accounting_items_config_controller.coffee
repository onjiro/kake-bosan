#= require angular/modules/kake-bosan

angular.module('kake-bosan').controller 'AccountingItemsConfigController', [
  '$scope',
  ($scope) ->
    $scope.updateAccountingItem = (item) ->
      item.$update (data) -> delete item.editing
    $scope.toggleItemSelectable = (item) ->
      item.updating = true
      item.selectable = !item.selectable
      item.$update(
        angular.noop
        (err) -> alert "#{err.status}: #{err.statusText}"
      ).finally () -> delete item.updating
]
