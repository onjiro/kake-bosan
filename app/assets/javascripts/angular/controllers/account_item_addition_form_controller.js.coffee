#= require angular/modules/kake-bosan

angular.module('kake-bosan').controller 'AccountItemAdditionFormController', [
  '$scope', '$rootScope', 'Item',
  ($scope, $rootScope, Item) ->
    resetInputs = () ->
      $scope.selected_type = $scope.types[0]
      $scope.name = ""
      $scope.description = ""
    onFailure = (err) -> console.log(err)
      
    $scope.$on('Item::new', (item) -> resetInputs())

    $scope.onSubmit = () -> Item.save
      name: $scope.name
      type_id: $scope.selected_type.id
      description: $scope.description
      (item) -> $rootScope.$broadcast('Item::new', item)
      (err) -> onFailure(err)

    # initialize
    resetInputs()
]
