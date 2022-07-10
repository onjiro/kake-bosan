import React from "react";
import { Form, InputGroup } from "react-bootstrap";

export default React.forwardRef((props, ref) => {
  return (
    <Form.Group>
      <InputGroup>
        <InputGroup.Text>&yen;</InputGroup.Text>
        <Form.Control type="number" className="text-end" ref={ref} {...props} />
      </InputGroup>
    </Form.Group>
  );
});
