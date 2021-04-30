#= require angular/modules/kake-bosan
#= require angular/models/inventory_setting

angular.module('kake-bosan').controller 'InventoryOppositeItemsConfigController', ['$scope', 'InventorySetting', ($scope, InventorySetting) ->
  $scope.setting = InventorySetting.query()

  $scope.saveInventorySetting = () ->
    $scope.setting.$update().then () ->
      notify '変更を保存しました。'

  # TODO
  notify = (text) ->
    console.log text
]
