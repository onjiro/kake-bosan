#= require angular/models/transaction

angular.module('kake-bosan').factory 'TransactionHistory', [
  'Transaction', 'ErrorHandler'
  (Transaction, ErrorHandler) ->
    (options) ->
      addDays = (date, days) -> new Date(date.getFullYear(), date.getMonth(), date.getDate() + days)

      options = options || {}
      options.days = options.days || 7
      options.from = options.from || addDays(new Date(), -options.days)

      ret =
        initialized: false
        loading: false
        transactions: []
        currentTerm: {}
        nextTerm: {}
        # 読み込み済みトランザクションの次の期間のデータをロード
        loadInNextTerm: () ->
          self = this
          self.loading = true
          newTransactions = Transaction.query {
            from: self.nextTerm.from && self.nextTerm.from.toLocaleString()
            to:   self.nextTerm.to   && self.nextTerm.to.toLocaleString()
          }, ((data) ->
            Array.prototype.push.apply(self.transactions, data)
            console.log(data)
            console.log(self.transactions.length)
            self.currentTerm.from = self.nextTerm.from
            self.nextTerm.to   = self.currentTerm.from
            self.nextTerm.from = addDays(self.nextTerm.to, -options.days)
          ), ErrorHandler
          return newTransactions.$promise.finally () -> self.loading = false
        # ロード済みのデータをリセットする
        reset: () ->
          self = this
          this.initialized = false
          this.transactions.splice(0, this.transactions.length)
          this.currentTerm.from = null
          this.currentTerm.to   = null
          this.nextTerm.from = options.from
          this.nextTerm.to   = null
          return this.loadInNextTerm().then () -> self.initialized = true

      # 初期化開始
      ret.reset()
      return ret
]
