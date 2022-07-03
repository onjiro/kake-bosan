import React from "react";
import { Nav } from "react-bootstrap";
import { Link } from "react-router-dom";

export default ({ href, to, icon, children }) => {
  if (to) {
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
  } else {
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
  }
};
