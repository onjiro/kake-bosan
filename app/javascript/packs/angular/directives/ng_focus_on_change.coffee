angular.module('kake-bosan').directive 'ngFocusOnChange', ['$timeout', ($timeout) ->
  return {
    link: (scope, element, attrs) ->
      scope.$watch attrs.ngFocusOnChange, (newValue, oldValue) ->
        # use $timeout for avoid "Error: [$rootScope: inprog]"
        # https://docs.angularjs.org/error/$rootScope/inprog?p0=$digest
        if newValue != oldValue then $timeout () -> $(element).focus()
  }
]
