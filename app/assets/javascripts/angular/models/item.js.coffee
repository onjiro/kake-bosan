#= require angular/modules/kake-bosan

angular.module('kake-bosan').factory 'Item', ['$resource', ($resource) ->
  return $resource '/accounting/items/:id.json', {
    id: '@id',
    user_id: null,
    name: null,
    accounting_type: null,
    description: null,
  },
  {
    update: { method: 'PUT' },
  }
]
