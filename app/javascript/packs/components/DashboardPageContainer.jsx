import React, { Suspense } from "react";
import { Spinner } from "react-bootstrap";
import DashboardPage from "./DashboardPage";
import { AlertContextProvider, AlertOutlet } from "../hooks/useAlert";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import InventoriesPage from "./InventoriesPage";

export default (_props) => {
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
            <Route path="/dashboard" element={<DashboardPage />} />
            <Route path="/inventories" element={<InventoriesPage />} />
          </Routes>
          <AlertOutlet />
        </AlertContextProvider>
      </Suspense>
    </BrowserRouter>
  );
};
