import "underscore"
import "../modules/kake-bosan"
import "../models/item"

angular.module('kake-bosan').filter 'byItemType', ['Item', (Item) ->
  items = Item.query()

  return (entries, itemTypes) ->
    _.filter entries, (entry) -> _.contains(itemTypes, _.findWhere(items, { id: entry.item_id })?.type_id)
]
