import React, { Suspense } from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import { Spinner } from "react-bootstrap";
import { AlertContextProvider, AlertOutlet } from "./hooks/useAlert";
import DashboardPage from "./pages/DashboardPage";
import InventoriesPage from "./pages/InventoriesPage";
import SummariesPage from "./pages/SummariesPage";
import ConfigsPage from "./pages/ConfigsPage";

export default () => {
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
            <Route path="/summaries" element={<SummariesPage />} />
            <Route path="/configs" element={<ConfigsPage />} />
          </Routes>

          <AlertOutlet />
        </AlertContextProvider>
      </Suspense>
    </BrowserRouter>
  );
};
