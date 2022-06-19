import { format } from "date-fns/esm";
import React, { useCallback, useState } from "react";
import TransactionModal from "./TransactionModal";

export default () => {
  const [transaction, setTransaction] = useState(null);
  const open = (transaction) => {
    setTransaction(
      transaction || {
        date: format(new Date(), "yyyy-MM-dd"),
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
    (props) => {
      return (
        <TransactionModal
          transaction={transaction}
          onClose={close}
          {...props}
        />
      );
    },
    [transaction, close]
  );

  return [ModalWrapper, open, close, isOpen];
};
