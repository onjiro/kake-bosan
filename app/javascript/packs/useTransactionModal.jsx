import React, { useCallback, useState } from "react";
import TransactionModal from "./TransactionModal";

export default () => {
  const [transaction, setTransaction] = useState(null);
  const open = (transaction) => {
    setTransaction(
      transaction || {
        date: format(today, "yyyy-MM-dd"),
        entries: [
          { side_id: 1, amount: 0 },
          { side_id: 2, amount: 0 },
        ],
      }
    );
  };
  const close = () => {
    setTransaction(null);
  };
  const isOpen = () => {
    !!transaction;
  };

  const ModalWrapper = useCallback(
    ({ onSubmit }) => {
      return (
        <TransactionModal
          transaction={transaction}
          onClose={close}
          onSubmit={onSubmit}
        />
      );
    },
    [transaction, close]
  );

  return [ModalWrapper, open, close, isOpen];
};