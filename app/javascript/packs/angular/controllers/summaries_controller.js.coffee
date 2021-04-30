#= require angular/modules/kake-bosan

angular.module('kake-bosan')
  .factory 'Summary', [
    '$resource',
    ($resource) ->
      return $resource '/accounting/summaries/:item_id.json', {
        item_id: '@item_id',
      }
  ]
  .controller 'SummariesController', [
    '$scope', 'Summary'
    ($scope, Summary) ->
      today = new Date()
      $scope.inputTo = today
      $scope.inputFrom = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate())
      $scope.summaryAccounts = Summary.query
        from: $scope.inputFrom
        to: $scope.inputTo

      $scope.onTermChanged = (from, to) ->
        return if !from || !to
        $scope.summaryAccounts = Summary.query
          from: from
          to: to
  ]
