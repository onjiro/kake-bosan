import React, { Suspense } from "react";
import { Alert, Container, Spinner } from "react-bootstrap";
import useTransitions from "./useTransactions";
import useTransactionModal from "./useTransactionModal";
import TranasctionHistory from "./TransactionHistory";
import TransactionHistoryItem from "./TransactionHistoryItem";
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
        <Container className="position-fixed top-0 start-0 mt-2">
          <Alert variant="success">アラートだよ</Alert>
        </Container>
      </Suspense>
    </>
  );
};
