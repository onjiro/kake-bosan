#= require angular/modules/kake-bosan
#= require angular/models/transaction_history
import React from 'react'
import * as ReactDOM from 'react-dom/client'
import EditModal from '../../EditModal'
import TranasctionHistory from '../../TransactionHistory'

angular.module('kake-bosan').controller 'RecentTransactionsController', [
  '$scope', 'TransactionHistory',
  ($scope, TransactionHistory) ->
    # properties
    newTransactions = $scope.newTransactions = []
    history = $scope.history = new TransactionHistory({ days: 7 })
    recents = $scope.recents = history.transactions
    
    currentTransaction = null
    modalRoot = ReactDOM.createRoot(document.querySelector('#react-modal-container'));
    renderModal = () => (modalRoot.render(React.createElement(EditModal, {
      transaction: currentTransaction,
      onClose: () =>
        currentTransaction = null;
        renderModal();
    })));

    historyRoot = ReactDOM.createRoot(document.querySelector('#react-list-container'));
    renderHistory = () => (historyRoot.render(React.createElement(TranasctionHistory, {
      transactions: $scope.recents,
      openEditModal: (transaction) =>
        currentTransaction = transaction;
        renderModal();
    })));
    $scope.$watch(
      () => $scope.recents,
      renderHistory,
      true
    );

    # relation from other controllers
    $scope.$on 'Transaction::new', (e, transaction) ->
      newTransactions.push(transaction)
    $scope.$on 'Transaction::remove', (event, transaction) ->
      position = newTransactions.indexOf(transaction)
      newTransactions.splice(position, 1) if position != -1
    $scope.$on 'Transaction::remove', (event, transaction) ->
      position = recents.indexOf(transaction)
      recents.splice(position, 1) if position != -1

    # actions
]
