#= require angular/modules/kake-bosan

angular.module('kake-bosan').controller 'AccountingItemsConfigController', ['$scope', ($scope) ->
  $scope.updateAccountingItem = (item) ->
    item.$update (data) -> delete item.editing
  $scope.toggleItemSelectable = (item) ->
    item.updating = true
    item.selectable = !item.selectable
    item.$update()
      .finally () -> delete item.updating
]
