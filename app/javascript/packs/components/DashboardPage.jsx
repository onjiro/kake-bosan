import React, { useState } from "react";
import useTransactionModal from "../hooks/useTransactionModal";
import TranasctionHistory from "./TransactionHistory";
import { format, subDays, addDays } from "date-fns";
import Footer from "./Footer";
import useAlert from "../hooks/useAlert";
import { Button } from "react-bootstrap";
import TransactionHistoryPage from "./TransactionHistoryPage";

export default (_props) => {
  const { success } = useAlert();
  const [TransactionModal, openModal] = useTransactionModal();

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
      <Footer onClickNewButton={() => openModal()} />

      <TransactionModal
        onSubmit={() => {
          success("取引を保存しました。");
        }}
        onDelete={() => {
          success("取引を削除しました。");
        }}
      />
    </>
  );
};
