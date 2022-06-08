import React from "react";
import { ListGroup, ListGroupItem } from "react-bootstrap";

export default (props) => {
  return (
    <ListGroup variant="flush">
      {props.transactions.map((t) => (
        <ListGroupItem
          action
          key={t.id}
          onClick={() => props.openEditModal(t)}
          className="list-group-item list-group-item-action"
        >
          <div style={{ fontSize: "xx-small" }}>
            {new Date(t.date).toISOString().substring(0, 10)}
          </div>
          <div>
            <span>
              {t.entries
                .filter((e) => e.side_id === 1)
                .map((e) => e.item.name)
                .join(",")}
            </span>
            <span className="float-end">
              <span style={{ fontSize: "xx-small" }}>
                {t.entries
                  .filter((e) => e.side_id === 2)
                  .map((e) => e.item.name)
                  .join(",")}
                &nbsp;
              </span>
              <span>
                &yen;
                {t.entries
                  .filter((e) => e.side_id === 1)
                  .reduce((sum, e) => sum + e.amount, 0)}
              </span>
            </span>
          </div>
        </ListGroupItem>
      ))}
    </ListGroup>
  );
};
