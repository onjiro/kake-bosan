import React, { useCallback, useState } from "react";
import TransactionModal from "./TransactionModal";

export default () => {
  const [transaction, setTransaction] = useState(null);
  const open = (transaction) => {
    setTransaction(transaction);
  };
  const close = () => {
    setTransaction(null);
  };
  const isOpen = () => {
    !!transaction;
  };

  const ModalWrapper = useCallback(
    (_props) => {
      return (
        <TransactionModal
          transaction={transaction}
          onClose={close}
          onDelete={() => {
            console.log("onDeelete");
          }}
        />
      );
    },
    [transaction, close]
  );

  return [ModalWrapper, open, close, isOpen];
};
