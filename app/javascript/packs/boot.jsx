import React from "react";
import * as ReactDOM from "react-dom/client";
import App from "./components/App";

document.addEventListener("DOMContentLoaded", () => {
  const root = ReactDOM.createRoot(
    document.querySelector("#rx-dashboard-container")
  );
  root.render(React.createElement(App));
});
