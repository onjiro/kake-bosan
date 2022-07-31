import React from "react";
import { Link } from "react-router-dom";

export default ({ to, icon, children }) => {
  return (
    <Link
      to={to}
      style={{
        padding: "0 1rem",
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
      }}
    >
      <span style={{ fontSize: "x-large" }}>{icon}</span>
      <span style={{ fontSize: "xx-small" }}>{children}</span>
    </Link>
  );
};
