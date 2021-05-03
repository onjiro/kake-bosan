import "../modules/kake-bosan"
import "../models/item"

angular.module('kake-bosan').controller 'AppController', [
  '$scope', '$rootScope', '$compile', 'Item'
  ($scope, $rootScope, $compile, Item) ->
    $scope.types = [
      { id: 1, name: "資産", side_id: 1 },
      { id: 2, name: "費用", side_id: 1 },
      { id: 3, name: "負債", side_id: 2 },
      { id: 4, name: "資本", side_id: 2 },
      { id: 5, name: "収益", side_id: 2 },
    ]
    $scope.items = Item.query()

    $scope.$on('Item::new', (e, item) -> $scope.items.push(angular.extend(item, { new: true })))
    document.addEventListener("turbolinks:load", (() ->
      $rootScope.$broadcast("$destroy")
      $compile(document.body)($rootScope)), {once: true})

    $scope.remove = (transaction) ->
      return unless confirm "本当に削除してよろしいですか？"
      transaction.$remove(
        (data, res) -> $rootScope.$broadcast 'Transaction::remove', transaction
        (err) -> alert "#{err.status}: #{err.statusText}"
      )
]
