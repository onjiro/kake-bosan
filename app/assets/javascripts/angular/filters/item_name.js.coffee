#= require angular/modules/kake-bosan
#= require angular/models/item
#= require underscore

angular.module('kake-bosan').filter 'itemName', ['Item', (Item) ->
  items = Item.query()
  return (item_id) -> _.findWhere(items, {id: item_id})?.name
]
