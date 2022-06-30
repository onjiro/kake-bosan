import React from "react";
import { Nav } from "react-bootstrap";

export default ({ href, icon, children }) => {
  return (
    <Nav.Link
      href={href}
      style={{
        padding: "0 1rem",
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
      }}
    >
      <span style={{ fontSize: "x-large" }}>{icon}</span>
      <span style={{ fontSize: "xx-small" }}>{children}</span>
    </Nav.Link>
  );
};
