import React, { useMemo, useState } from "react";
import { Button, Modal, Form, InputGroup, Row } from "react-bootstrap";
import { useForm } from "react-hook-form";
import { BsClock } from "react-icons/bs";
import ItemSelector from "./ItemSelector";
import useItems from "./useItems";

export default ({ transaction, onClose, onDelete }) => {
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm();
  const { items, error } = useItems();

  if (!transaction || !items) {
    return null;
  }
  const debits = useMemo(
    () => transaction.entries.filter((e) => e.side_id === 1),
    transaction.entries
  );
  const credits = useMemo(
    () => transaction.entries.filter((e) => e.side_id === 2),
    transaction.entries
  );

  const save = handleSubmit((data) => console.log(data));

  return (
    <Modal
      show={transaction}
      onHide={onClose}
      backdrop="static"
      keyboard={false}
      fullscreen={true}
    >
      <Form onSubmit={save}>
        <Modal.Header closeButton>
          <Modal.Title>{transaction.id ? "編集" : "新規"}</Modal.Title>
        </Modal.Header>

        <Modal.Body>
          <input
            type="hidden"
            {...register("id")}
            defaultValue={transaction.id}
          />
          <Row className="mb-2">
            <Form.Group>
              <InputGroup>
                <InputGroup.Text>
                  <BsClock></BsClock>
                </InputGroup.Text>
                <Form.Control
                  type="date"
                  {...register("date")}
                  defaultValue={transaction.date}
                />
              </InputGroup>
            </Form.Group>
          </Row>

          <Row className="mb-2">
            {debits.map((e, index) => {
              return (
                <div key={index}>
                  <ItemSelector
                    placeholder="【借方】"
                    items={items}
                    initialFilter="費用"
                    {...register(`debits[${index}].item_id`)}
                    defaultValue={e.item_id}
                  />
                  <Form.Group>
                    <InputGroup>
                      <InputGroup.Text>&yen;</InputGroup.Text>
                      <Form.Control
                        type="number"
                        {...register(`debits[${index}].amount`)}
                        defaultValue={e.amount}
                      />
                    </InputGroup>
                  </Form.Group>
                </div>
              );
            })}

            {credits.map((e, index) => {
              return (
                <div key={index}>
                  <ItemSelector
                    placeholder="【貸方】"
                    items={items}
                    initialFilter="資産, 負債"
                    {...register(`credits[${index}].item_id`)}
                    defaultValue={e.item_id}
                  />
                  <Form.Group>
                    <InputGroup>
                      <InputGroup.Text>&yen;</InputGroup.Text>
                      <Form.Control
                        type="number"
                        {...register(`credits[${index}].amount`)}
                        defaultValue={e.amount}
                      />
                    </InputGroup>
                  </Form.Group>
                </div>
              );
            })}
          </Row>

          {transaction.id ? (
            <div className="d-grid gap-2">
              <Button variant="danger" onClick={onDelete}>
                削除
              </Button>
            </div>
          ) : null}
        </Modal.Body>

        <Modal.Footer>
          <Button variant="secondary" onClick={onClose}>
            キャンセル
          </Button>
          <Button variant="primary" type="submit">
            保存
          </Button>
        </Modal.Footer>
      </Form>
    </Modal>
  );
};
