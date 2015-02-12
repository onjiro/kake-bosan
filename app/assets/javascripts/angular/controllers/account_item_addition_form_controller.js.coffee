#= require angular/modules/kake-bosan

angular.module('kake-bosan').controller 'AccountItemAdditionFormController', [
  '$scope', 'Item',
  ($scope, Item) ->
    resetInputs = () ->
      $scope.selected_type = $scope.types[0]
      $scope.newItemName = ""
    onFailure = (err) -> console.log(err)
      
    $scope.onSubmit = () -> Item.save
      name: $scope.newItemName
      type_id: $scope.selected_type.id
      description: null
      () -> resetInputs()
      () -> onFailure()

    # initialize
    resetInputs()
]
