#= require angular/models/transaction

angular.module('kake-bosan').service 'Transaction.recents', [
  'Transaction',
  (Transaction) ->
    today = new Date()
    from = new Date(today.getFullYear(), today.getMonth(), today.getDate() - 6)

    # ロードすると直近のトランザクションを問答無用で取得する
    Transaction.recents = Transaction.query
      from: from.toLocaleString()
      to:   new Date(today.getFullYear(), today.getMonth(), today.getDate() + 1).toLocaleString()

    # さらに直近のトランザクションを取得する
    Transaction.recents.loadAdditionals = (options) ->
      Transaction.recents.appending = true
      Transaction.query {
        from: new Date(from.getFullYear(), from.getMonth(), from.getDate() - 8).toLocaleString()
        to:   new Date(from.getFullYear(), from.getMonth(), from.getDate() - 1).toLocaleString()
      }, ((data) ->
        # Transaction.recents.push one for one in data と同じ
        Array.prototype.push.apply(Transaction.recents, data)
        from = new Date(from.getFullYear(), from.getMonth(), from.getDate() - 8)
        delete Transaction.recents.appending
      ), ((err) ->
        delete Transaction.recents.appending
      )
]
