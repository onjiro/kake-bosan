import React from "react";
import { ListGroup } from "react-bootstrap";
import TransactionHistoryItem from "./TransactionHistoryItem";

export default ({ transactions, onClickItem }) => {
  if (transactions == null) return null;

  return (
    <ListGroup variant="flush">
      {transactions.map((t) => (
        <TransactionHistoryItem
          key={t.id}
          transaction={t}
          onClick={onClickItem}
        />
      ))}
    </ListGroup>
  );
};
