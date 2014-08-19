#= require angular/modules/kake-bosan

angular.module('kake-bosan').factory 'Inventory', ['$resource', ($resource) ->
  return $resource '/accounting/inventories/:item_id.json', {
    item_id: '@item_id',
  },
  {
    query:  { method: 'GET', isArray: true, cache: true },
    update: { method: 'PUT' },
  }
]
