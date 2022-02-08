import "../modules/kake-bosan"

angular.module('kake-bosan').directive 'suggestOnUnbalanced', [
  '$parse', '$rootScope', '$compile',
  ($parse, $rootScope, $compile) ->
    return {
      scope: true
      require: 'ngModel'
      link: (scope, element, attrs, ngModelController) ->
        transaction = $parse(attrs.suggestOnUnbalanced)(scope)
        side = attrs.suggestSide
        disableCondition = attrs.suggestDisableOn
        tooltip = $(angular.element('<div class="tooltip tooltip-suggestion bs-tooltip-start fade" role="tooltip" ng-click="applySuggest($event)"><div class="tooltip-arrow"></div><a href="#" class="tooltip-inner"></a></div>'))
        tooltipInner = tooltip.find('.tooltip-inner')
        suggestAmount = 0
        $(element).before tooltip
        $compile(tooltip)(scope)
        tooltip.css
          top: 0
          left: 0
          marginTop: '6px'

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
          return if suggestAmount <= 0 || suggestAmount == ngModelController.$modelValue
          showSuggestion(suggestAmount)

        element.on 'keyup', (e) ->
          return unless (e.keyCode == 27)
          $rootScope.$broadcast 'suggestOnUnbalanced:clear', element
        scope.$on 'suggestOnUnbalanced:clear', (e, srcElement) ->
          dismissSuggestion()

        # DOM 操作関連
        # サジェスト金額の表示と消去
        showSuggestion = (suggestAmount) ->
          tooltipInner.text("#{suggestAmount}?")
          tooltip.addClass('show')
          tooltip.css('marginLeft', "-#{$(tooltip).innerWidth()}px")

        dismissSuggestion = () ->
          tooltip.removeClass('show')

        scope.applySuggest = ($event) ->
          $event.preventDefault();
          ngModelController.$setViewValue(suggestAmount, 'onUpdate')
          ngModelController.$render()
          $rootScope.$broadcast 'suggestOnUnbalanced:changed', element
    }
]
