import "../modules/kake-bosan"

angular.module('kake-bosan').factory 'Item', ['$resource', ($resource) ->
  return $resource '/accounting/items/:id.json', {
    id: '@id',
    user_id: null,
    name: null,
    accounting_type: null,
    description: null,
  },
  {
    query: {method: 'GET', isArray: true, cache: true},
    update: { method: 'PUT', transformRequest: (data) -> (JSON.stringify({name: data.name, selctable: data.selectable, description: data.description, type_id: data.type_id})) },
  }
]
