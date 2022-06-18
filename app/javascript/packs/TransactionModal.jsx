import React from "react";
import {
  Button,
  Modal,
  Form,
  InputGroup,
  Dropdown,
  Row,
} from "react-bootstrap";
import { BsClock } from "react-icons/bs";
import useItems from "./useItems";

export default ({ transaction, onClose, onDelete }) => {
  const { items, error } = useItems();

  if (!transaction || !items) {
    return null;
  }

  return (
    <Modal
      show={transaction}
      onHide={onClose}
      backdrop="static"
      keyboard={false}
      fullscreen={true}
    >
      <Modal.Header closeButton>
        <Modal.Title>編集</Modal.Title>
      </Modal.Header>

      <Modal.Body>
        <Form>
          <Row className="mb-2">
            <Form.Group>
              <InputGroup>
                <InputGroup.Text>
                  <BsClock></BsClock>
                </InputGroup.Text>
                <Form.Control
                  type="date"
                  value={transaction.date}
                ></Form.Control>
              </InputGroup>
            </Form.Group>
          </Row>

          <Row className="mb-2">
            {/* 借方 */}
            <Form.Group>
              <InputGroup>
                <Dropdown>
                  <Dropdown.Toggle variant="outline-secondary">
                    費用
                  </Dropdown.Toggle>
                  <Dropdown.Menu>
                    <Dropdown.Item>資産・負債</Dropdown.Item>
                    <Dropdown.Item>費用</Dropdown.Item>
                    <Dropdown.Item>利益</Dropdown.Item>
                    <Dropdown.Item>資本</Dropdown.Item>
                    <Dropdown.Item>フィルタなし</Dropdown.Item>
                  </Dropdown.Menu>
                </Dropdown>
                <Form.Select>
                  <option>【借方】</option>
                  {items.map((item) => (
                    <option key={item.id} value={item.id}>
                      {item.name}
                    </option>
                  ))}
                </Form.Select>
              </InputGroup>
            </Form.Group>

            <Form.Group>
              <InputGroup>
                <InputGroup.Text>&yen;</InputGroup.Text>
                <Form.Control type="number"></Form.Control>
              </InputGroup>
            </Form.Group>

            {/* 貸方 */}
            <Form.Group>
              <InputGroup>
                <Dropdown>
                  <Dropdown.Toggle variant="outline-secondary">
                    費用
                  </Dropdown.Toggle>
                  <Dropdown.Menu>
                    <Dropdown.Item>資産・負債</Dropdown.Item>
                    <Dropdown.Item>費用</Dropdown.Item>
                    <Dropdown.Item>利益</Dropdown.Item>
                    <Dropdown.Item>資本</Dropdown.Item>
                    <Dropdown.Item>フィルタなし</Dropdown.Item>
                  </Dropdown.Menu>
                </Dropdown>
                <Form.Select>
                  <option>【借方】</option>
                  {items.map((item) => (
                    <option key={item.id} value={item.id}>
                      {item.name}
                    </option>
                  ))}
                </Form.Select>
              </InputGroup>
            </Form.Group>

            <Form.Group>
              <InputGroup>
                <InputGroup.Text>&yen;</InputGroup.Text>
                <Form.Control type="number"></Form.Control>
              </InputGroup>
            </Form.Group>
          </Row>
        </Form>
        <div className="d-grid gap-2">
          <Button variant="danger" onClick={onDelete}>
            削除
          </Button>
        </div>
      </Modal.Body>

      <Modal.Footer>
        <Button variant="secondary" onClick={() => onClose()}>
          Close
        </Button>
        <Button variant="primary">Save changes</Button>
      </Modal.Footer>
    </Modal>
  );
};
