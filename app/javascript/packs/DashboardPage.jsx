import React, { Suspense } from "react";
import { Row, Spinner } from "react-bootstrap";
import useTransitions from "./useTransactions";
import useTransactionModal from "./useTransactionModal";
import TranasctionHistory from "./TransactionHistory";
import { format } from "date-fns";
import subDays from "date-fns/subDays";
import Footer from "./Footer";

export default (_props) => {
  const today = new Date();
  const from = format(subDays(today, 7), "yyyy-MM-dd");
  const to = format(today, "yyyy-MM-dd");
  const { transactions, error, mutate } = useTransitions({ from, to });
  const [TransactionModal, openModal] = useTransactionModal();

  return (
    <>
      <Suspense
        fallback={
          <Spinner animation="border" role="status">
            <span className="visually-hidden">Loading...</span>
          </Spinner>
        }
      >
        <h3>▼直近７日間の履歴</h3>
        <Row>
          <TranasctionHistory
            transactions={transactions}
            onClickItem={openModal}
          />
        </Row>
        <Footer onClickNewButton={openModal} />
        <TransactionModal onSubmit={mutate} />
      </Suspense>
    </>
  );
};
