import React, { useMemo, useState } from "react";
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
  const itemFilters = [
    { key: "資産・負債", typeIds: [1, 3] },
    { key: "費用", typeIds: [2] },
    { key: "利益", typeIds: [5] },
    { key: "資本", typeIds: [4] },
    { key: "フィルタなし", typeIds: [1, 2, 3, 4, 5] },
  ];
  const [debitItemFilter, setDebitItemFilter] = useState(itemFilters[1]);
  const [creditItemFilter, setCreditItemFilter] = useState(itemFilters[0]);

  if (!transaction || !items) {
    return null;
  }

  const debitItems = useMemo(
    () =>
      items.filter((item) => debitItemFilter.typeIds.includes(item.type_id)),
    [items, debitItemFilter]
  );
  const creditItems = useMemo(
    () =>
      items.filter((item) => creditItemFilter.typeIds.includes(item.type_id)),
    [items, creditItemFilter]
  );

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
                    {debitItemFilter["key"]}
                  </Dropdown.Toggle>
                  <Dropdown.Menu>
                    {itemFilters.map(({ key, typeIds }) => (
                      <Dropdown.Item
                        key={key}
                        onClick={() => setDebitItemFilter({ key, typeIds })}
                      >
                        {key}
                      </Dropdown.Item>
                    ))}
                  </Dropdown.Menu>
                </Dropdown>
                <Form.Select>
                  <option>【借方】</option>
                  {debitItems.map((item) => (
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
                    {creditItemFilter["key"]}
                  </Dropdown.Toggle>
                  <Dropdown.Menu>
                    {itemFilters.map(({ key, typeIds }) => (
                      <Dropdown.Item
                        key={key}
                        onClick={() => setCreditItemFilter({ key, typeIds })}
                      >
                        {key}
                      </Dropdown.Item>
                    ))}
                  </Dropdown.Menu>
                </Dropdown>
                <Form.Select>
                  <option>【借方】</option>
                  {creditItems.map((item) => (
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
