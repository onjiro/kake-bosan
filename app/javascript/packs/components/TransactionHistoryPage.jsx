import React, { useEffect } from "react";
import TransactionHistoryItem from "./TransactionHistoryItem";
import { differenceInMilliseconds } from "date-fns";
import useTransactions from "../hooks/useTransactions";

export default ({ range, onClick }) => {
  const { transactions, error } = useTransactions(range);
  useEffect(
    () =>
      error &&
      danger(`取引の取得に失敗しました。リロードしてください。\n${error}`),
    [error]
  );

  return (
    <>
      {transactions
        ?.slice()
        .reverse()
        .map((t) => (
          <TransactionHistoryItem
            key={t.id}
            transaction={t}
            onClick={onClick}
            highlighted={
              differenceInMilliseconds(new Date(), new Date(t.updated_at)) <
              60000
            }
          />
        ))}
    </>
  );
};
