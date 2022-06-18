import React from "react";
import { ListGroupItem } from "react-bootstrap";

export default ({ transaction, onClick }) => {
  const formattedDate = new Date(transaction.date)
    .toISOString()
    .substring(0, 10);
  const debitItemNames = transaction.entries
    .filter((e) => e.side_id === 1)
    .map((e) => e.item.name)
    .join(",");
  const creditItemNames = transaction.entries
    .filter((e) => e.side_id === 2)
    .map((e) => e.item.name)
    .join(",");
  const amountSum = transaction.entries
    .filter((e) => e.side_id === 1)
    .reduce((sum, e) => sum + e.amount, 0);

  return (
    <ListGroupItem
      action
      key={transaction.id}
      onClick={() => onClick(transaction)}
      className="list-group-item list-group-item-action"
    >
      <div style={{ fontSize: "xx-small" }}>{formattedDate}</div>
      <div>
        <span>{debitItemNames}</span>
        <span className="float-end">
          <span style={{ fontSize: "xx-small" }}>{creditItemNames}&nbsp;</span>
          <span>&yen;{amountSum}</span>
        </span>
      </div>
    </ListGroupItem>
  );
};
