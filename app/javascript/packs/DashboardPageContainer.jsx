import React, { Suspense } from "react";
import { Spinner } from "react-bootstrap";
import DashboardPage from "./DashboardPage";
import { AlertContextProvider, AlertOutlet } from "./useAlert";

export default (_props) => {
  return (
    <>
      <Suspense
        fallback={
          <Spinner animation="border" role="status">
            <span className="visually-hidden">Loading...</span>
          </Spinner>
        }
      >
        <AlertContextProvider>
          <DashboardPage />
          <AlertOutlet />
        </AlertContextProvider>
      </Suspense>
    </>
  );
};
