#= require angular/modules/kake-bosan

angular.module('kake-bosan').directive 'suggestOnUnbalanced', [
  '$parse', '$rootScope'
  ($parse, $rootScope) ->
    return {
      require: 'ngModel'
      link: (scope, element, attrs, ngModelController) ->
        transaction = $parse(attrs.suggestOnUnbalanced)(scope)
        side = attrs.suggestSide
        disableCondition = attrs.suggestDisableOn

        # イベント関連
        # モデル変更時のイベント発火と他要素からのイベント待ち受け
        #ngModelController.$viewChangeListeners.push () ->
        ngModelController.$viewChangeListeners.push () ->
          $rootScope.$broadcast 'suggestOnUnbalanced:changed', element
        scope.$on 'suggestOnUnbalanced:changed', (e, srcElement) ->
          dismissSuggestion()
          return if element == srcElement
          return if $parse(disableCondition)(scope)
          suggestAmount = transaction.suggestToBalance(side) + ngModelController.$modelValue
          return if suggestAmount <= 0
          showSuggestion(element, suggestAmount)

        # DOM 操作関連
        # サジェスト金額の表示と消去
        showSuggestion = (element, amount) ->
          console.log amount, side
        dismissSuggestion = () ->
          # noop
    }
]
