import React from "react";
import useTransitions from "./useTransactions";
import useTransactionModal from "./useTransactionModal";
import TranasctionHistory from "./TransactionHistory";
import TransactionHistoryItem from "./TransactionHistoryItem";
import { format } from "date-fns";
import subDays from "date-fns/subDays";
import Footer from "./Footer";
import useAlert, { AlertOutlet } from "./useAlert";

export default (_props) => {
  const today = new Date();
  const from = format(subDays(today, 7), "yyyy-MM-dd");
  const to = format(today, "yyyy-MM-dd");
  const { transactions, error, mutate } = useTransitions({ from, to });
  const [TransactionModal, openModal] = useTransactionModal();
  const { success } = useAlert();

  return (
    <>
      <h3 onClick={() => success("hogehoge")}>▼直近７日間の履歴</h3>
      <TranasctionHistory>
        {transactions?.map((t) => (
          <TransactionHistoryItem
            key={t.id}
            transaction={t}
            onClick={openModal}
          />
        ))}
      </TranasctionHistory>
      <Footer onClickNewButton={() => openModal()} />

      <TransactionModal onSubmit={mutate} />
    </>
  );
};
