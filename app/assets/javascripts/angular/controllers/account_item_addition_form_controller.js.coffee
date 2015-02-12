#= require angular/modules/kake-bosan

angular.module('kake-bosan').controller 'AccountItemAdditionFormController', [
  '$scope', 'Item',
  ($scope, Item) ->
    resetInputs = () ->
      $scope.selected_type = $scope.types[0]
      $scope.newItemName = ""
    onFailure = (err) -> console.log(err)
      
    $scope.onSubmit = () -> Item.save
      user_id: '' # todo
      name: $scope.newItemName
      accounting_type: $scope.selected_type
      description: null
      () -> resetInputs()
      () -> onFailure()

    # initialize
    resetInputs()
]
