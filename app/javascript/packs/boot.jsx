import React from "react";
import * as ReactDOM from "react-dom/client";
import DashboardPage from "./DashboardPage";

document.addEventListener("DOMContentLoaded", () => {
  const root = ReactDOM.createRoot(
    document.querySelector("#rx-dashboard-container")
  );
  root.render(React.createElement(DashboardPage));
});
