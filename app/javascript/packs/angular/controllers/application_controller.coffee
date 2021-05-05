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

    # turbolinksとangular1を同居させるための暫定の仕組み
    #
    # turbolinksではページ遷移時にbodyだけを差し替えてしまう。
    # 通常angular1はこれを検知できないので、AppController以下は動作しない状態になる。
    # これを回避するため、tubolinksでページ遷移をした場合にbody以下を$compileしている。
    # 初回のページ表示時に$compileが動いてしまうとイベントが二重に設定されるなど想定しない事態が発生する。
    # これを避けるため、turbolinks:request-start後のturbolinks:loadでのみ動作するようにイベントを設定した。
    # この方法で概ねうまく動くような気がするけど、うまく動かないパターンもあるかもしれない
    document.addEventListener("turbolinks:request-start", ((event, url, prev_url) ->
      document.addEventListener("turbolinks:load", ((event) ->
        $rootScope.$broadcast("$destroy")
        $compile(document.body)($rootScope)), { once: true })), { once: true })

    $scope.remove = (transaction) ->
      return unless confirm "本当に削除してよろしいですか？"
      transaction.$remove(
        (data, res) -> $rootScope.$broadcast 'Transaction::remove', transaction
        (err) -> alert "#{err.status}: #{err.statusText}"
      )
]
