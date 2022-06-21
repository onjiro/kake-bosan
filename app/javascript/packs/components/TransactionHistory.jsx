import React from "react";
import { ListGroup, Row } from "react-bootstrap";

export default (props) => {
  return (
    <Row>
      <ListGroup variant="flush">{props.children}</ListGroup>
    </Row>
  );
};
