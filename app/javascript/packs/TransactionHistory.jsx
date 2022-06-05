import React from "react";

export default (props) => {
  return (
    <div className="list-group list-group-flush">
      {props.transactions.map((t) => (
        <a
          key={t.id}
          href="#"
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
            <span style={{ fontSize: "xx-small" }}>
              &nbsp;⇦&nbsp;
              {t.entries
                .filter((e) => e.side_id === 2)
                .map((e) => e.item.name)
                .join(",")}
            </span>
            <span className="float-end">
              &yen;
              {t.entries
                .filter((e) => e.side_id === 1)
                .reduce((sum, e) => sum + e.amount, 0)}
            </span>
          </div>
        </a>
      ))}
    </div>
  );
};
