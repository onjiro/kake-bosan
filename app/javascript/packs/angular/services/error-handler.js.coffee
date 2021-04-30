#= require angular/modules/kake-bosan

angular.module('kake-bosan').service('ErrorHandler', [
  () ->
    return (err) ->
      console.log(err)
])

