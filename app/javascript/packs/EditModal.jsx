import React from "react";
import { Button, Modal } from "react-bootstrap";

export default (props) => {
  return (
    <Modal
      show={props.transaction}
      onHide={props.onClose}
      backdrop="static"
      keyboard={false}
      fullscreen={true}
    >
      <Modal.Header closeButton>
        <Modal.Title>Modal title</Modal.Title>
      </Modal.Header>

      <Modal.Body>
        <p>Modal body text goes here.</p>
      </Modal.Body>

      <Modal.Footer>
        <Button variant="secondary" onClick={() => props.onClose()}>
          Close
        </Button>
        <Button variant="primary">Save changes</Button>
      </Modal.Footer>
    </Modal>
  );
};
