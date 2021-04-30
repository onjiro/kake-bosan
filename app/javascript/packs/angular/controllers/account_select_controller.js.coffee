#= require angular/modules/kake-bosan

angular.module('kake-bosan').controller 'AccountSelectController', ['$scope', ($scope) ->
  $scope.type_filters = [
    { title: "資産, 負債"  , type_ids: [1, 3] },
    { title: "費用"        , type_ids: [2] },
    { title: "利益"        , type_ids: [5] },
    { title: "資本"        , type_ids: [4] },
    { title: "フィルタなし", type_ids: [1, 2, 3, 4, 5] },
  ]
  $scope.current_filter = _.last($scope.type_filters)

  $scope.setCurrentFilter = (filter) -> $scope.current_filter = filter
]
