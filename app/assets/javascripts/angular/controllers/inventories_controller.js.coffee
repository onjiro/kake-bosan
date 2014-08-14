#= require angular/modules/kake-bosan
#= require angular/models/inventory

angular.module('kake-bosan').controller 'InventoriesController', ['$scope', 'Inventory', ($scope, Inventory) ->
  $scope.inventories = Inventory.query
    date: new Date()
]
