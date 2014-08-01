#= require angular/modules/kake-bosan

angular.module('kake-bosan').controller 'AccountingItemsConfigController', ['$scope', ($scope) ->
  $scope.updateAccountingItem = (item) ->
    item.$update (data) -> delete item.editing
]
