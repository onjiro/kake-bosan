import React, { Suspense } from "react";
import { Spinner } from "react-bootstrap";
import DashboardPage from "./DashboardPage";
import useAlert, { AlertContextProvider, AlertOutlet } from "../hooks/useAlert";
import useTransactionModal from "../hooks/useTransactionModal";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import InventoriesPage from "./InventoriesPage";
import Footer from "./Footer";

export default () => {
  const { success } = useAlert();
  const [TransactionModal, openModal] = useTransactionModal();

  return (
    <BrowserRouter>
      <Suspense
        fallback={
          <Spinner animation="border" role="status">
            <span className="visually-hidden">Loading...</span>
          </Spinner>
        }
      >
        <AlertContextProvider>
          <Routes>
            <Route
              path="/dashboard"
              element={<DashboardPage openModal={openModal} />}
            />
            <Route path="/inventories" element={<InventoriesPage />} />
          </Routes>
          <Footer onClickNewButton={() => openModal()} />

          <TransactionModal
            onSubmit={() => {
              success("取引を保存しました。");
            }}
            onDelete={() => {
              success("取引を削除しました。");
            }}
          />
          <AlertOutlet />
        </AlertContextProvider>
      </Suspense>
    </BrowserRouter>
  );
};
