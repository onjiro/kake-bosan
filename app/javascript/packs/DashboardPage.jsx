import React, { useEffect } from "react";
import useTransitions from "./useTransactions";
import useTransactionModal from "./useTransactionModal";
import TranasctionHistory from "./TransactionHistory";
import TransactionHistoryItem from "./TransactionHistoryItem";
import { differenceInMilliseconds, format } from "date-fns";
import subDays from "date-fns/subDays";
import Footer from "./Footer";
import useAlert from "./useAlert";

export default (_props) => {
  const today = new Date();
  const from = format(subDays(today, 7), "yyyy-MM-dd");
  const to = format(today, "yyyy-MM-dd");
  const { transactions, error, mutate } = useTransitions({ from, to });
  const [TransactionModal, openModal] = useTransactionModal();
  const { success, danger } = useAlert();
  useEffect(
    () =>
      error &&
      danger(`取引の取得に失敗しました。リロードしてください。\n${error}`),
    [error]
  );

  return (
    <>
      <h3>▼直近７日間の履歴</h3>
      <TranasctionHistory>
        {transactions?.map((t) => (
          <TransactionHistoryItem
            key={t.id}
            transaction={t}
            onClick={openModal}
            highlighted={
              differenceInMilliseconds(new Date(), new Date(t.updated_at)) <
              60000
            }
          />
        ))}
      </TranasctionHistory>
      <Footer onClickNewButton={() => openModal()} />

      <TransactionModal
        onSubmit={() => {
          success("取引を保存しました。");
          mutate();
        }}
        onDelete={() => {
          success("取引を削除しました。");
          mutate();
        }}
      />
    </>
  );
};
