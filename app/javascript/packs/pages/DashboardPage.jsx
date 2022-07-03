import React, { useState } from "react";
import TranasctionHistory from "../components/TransactionHistory";
import { format, subDays, addDays } from "date-fns";
import { Button } from "react-bootstrap";
import TransactionHistoryPage from "../components/TransactionHistoryPage";

export default ({ openModal }) => {
  const thirtyDaysTo = (date) => ({
    from: subDays(date, 31),
    to: subDays(date, 1),
  });
  const [ranges, setRanges] = useState([thirtyDaysTo(addDays(new Date(), 1))]);
  const more = () => {
    setRanges((state) => [
      ...state,
      thirtyDaysTo(state[state.length - 1].from),
    ]);
  };

  return (
    <>
      <h3>一覧</h3>
      <TranasctionHistory>
        {ranges.map((range) => (
          <TransactionHistoryPage
            key={range.from}
            range={{
              from: format(range.from, "yyyy-MM-dd"),
              to: format(range.to, "yyyy-MM-dd"),
            }}
            onClick={openModal}
          />
        ))}
      </TranasctionHistory>
      <div className="d-grid gap-2">
        <Button onClick={more}>さらに読み込む</Button>
      </div>
    </>
  );
};
