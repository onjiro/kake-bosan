#= require angular/modules/kake-bosan

angular.module('kake-bosan').factory 'Inventory', ['$resource', ($resource) ->
  return $resource '/accounting/items/inventories/:id.json', {
    id: '@id',
    user_id: null,
    name: null,
    accounting_type: null,
    amount: 0,
  },
  {
    query: { method: 'GET', isArray: true, cache: true },
  }
]
