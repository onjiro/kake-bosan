import "../modules/kake-bosan"
import "../models/item"
import "../models/type"
import "underscore"

angular.module('kake-bosan').filter 'itemType', ['Item', 'Type', (Item, Type) ->
  items = Item.query()
  types = Type.all
  (item_id) ->
    type_id = _.findWhere(items, {id: item_id})?.type_id
    return _.findWhere(types, {id: type_id})?.name
]
