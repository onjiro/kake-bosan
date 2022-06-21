import React from "react";
import { Button, Container, Nav, Navbar } from "react-bootstrap";
import { BsPencilSquare } from "react-icons/bs";

export default (props) => {
  return (
    <>
      <Navbar fixed="bottom" bg="light">
        <Container className="justify-content-end">
          <Nav>
            <Nav.Item>
              <Button variant="primary" onClick={props.onClickNewButton}>
                <BsPencilSquare></BsPencilSquare>
              </Button>
            </Nav.Item>
          </Nav>
        </Container>
      </Navbar>
    </>
  );
};
