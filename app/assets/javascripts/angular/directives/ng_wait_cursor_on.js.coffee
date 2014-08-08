angular.module('kake-bosan').directive 'ngWaitCursorOn', ['$timeout', ($timeout) ->
  return {
    link: (scope, element, attrs) ->
      scope.$watch attrs.ngWaitCursorOn, (condition) ->
        # use $timeout for avoid "Error: [$rootScope: inprog]"
        # https://docs.angularjs.org/error/$rootScope/inprog?p0=$digest
        $timeout () -> document.body.style.cursor = if condition then 'wait' else 'auto'
  }
]
