#= require angular/modules/kake-bosan

angular.module('kake-bosan').factory 'InventorySetting', ['$resource', ($resource) ->
  InventorySetting = $resource '/inventory_settings.json', {
  },
  {
    query:  { method: 'GET', isArray: false, cache: true }
    update: { method: 'PUT', transformRequest: (data) -> (JSON.stringify({debit_item_id: data.debit_item_id, credit_item_id: data.credit_item_id})) }
  }
  return InventorySetting
]
