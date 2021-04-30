#= require angular/modules/kake-bosan
#= require underscore

angular.module('kake-bosan').filter 'byAccount', [() ->
  (accountItems, accountTypes) ->
    _.filter accountItems, (item) -> _.contains(accountTypes, item.type_id)
]
