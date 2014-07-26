#= require angular/modules/kake-bosan

angular.module('kake-bosan').controller 'AccountSelectController', ['$scope', ($scope) ->
  $scope.type_filters = [
    { title: "資産"         },
    { title: "費用"         },
    { title: "負債"         },
    { title: "資本"         },
    { title: "利益"         },
    { title: "フィルタなし" },
  ]
  $scope.current_filter = $scope.type_filters[5]

  $scope.setCurrentFilter = (filter) -> $scope.current_filter = filter
]
