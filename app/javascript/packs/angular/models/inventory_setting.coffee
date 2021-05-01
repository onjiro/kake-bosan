#= require angular/modules/kake-bosan

angular.module('kake-bosan').factory 'InventorySetting', ['$resource', ($resource) ->
  InventorySetting = $resource '/inventory_settings.json', {
  },
  {
    query:  { method: 'GET', isArray: false, cache: true }
    update: { method: 'PUT' }
  }
  return InventorySetting
]
