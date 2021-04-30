angular.module('kake-bosan').directive 'ngFocusFirstInputIf', ['$timeout', ($timeout) ->
  return {
    link: (scope, element, attrs) ->
      scope.$watch attrs.ngFocusFirstInputIf, (condition) ->
        # use $timeout for avoid "Error: [$rootScope: inprog]"
        # https://docs.angularjs.org/error/$rootScope/inprog?p0=$digest
        if condition then $timeout () ->
          element.find("input, select, button, checkbox")[0]?.focus()
  }
]
