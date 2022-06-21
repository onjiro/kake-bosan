import React from "react";
import { Form, InputGroup } from "react-bootstrap";
import { BsClock } from "react-icons/bs";

export default React.forwardRef((props, ref) => {
  return (
    <Form.Group>
      <InputGroup>
        <InputGroup.Text>
          <BsClock></BsClock>
        </InputGroup.Text>
        <Form.Control type="date" ref={ref} {...props} />
      </InputGroup>
    </Form.Group>
  );
});
