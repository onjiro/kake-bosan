#= require angular/modules/kake-bosan

angular.module('kake-bosan').factory 'InventorySetting', ['$resource', ($resource) ->
  InventorySetting = $resource '/inventory_settings.json'

  return InventorySetting
]






