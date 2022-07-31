import React from "react";
import { Button, Modal, Form, Row, Col, FormLabel } from "react-bootstrap";
import { useForm } from "react-hook-form";
import { save } from "../hooks/useItems";
import ACCOUNTING_TYPES from "../utils/accountingTypes";

export default ({ item, onClose, onSubmit }) => {
  if (!item) return null;

  const { register, handleSubmit, watch, setValue, formState } = useForm();

  const saveItem = handleSubmit(async (formData, e) => {
    e.preventDefault();
    const _response = await save(formData);
    // TODO エラー時の対応
    onClose();
    onSubmit();
  });

  return (
    <Modal
      show={item}
      onHide={onClose}
      backdrop="static"
      keyboard={false}
      fullscreen={true}
    >
      <Form onSubmit={saveItem}>
        <Modal.Header closeButton>
          <Modal.Title>{item.name}</Modal.Title>
        </Modal.Header>

        <Modal.Body>
          <input type="hidden" defaultValue={item.id} {...register("id")} />
          <Form.Group className="mb-3">
            <Form.Label>名前</Form.Label>
            <Form.Control
              type="text"
              {...register("name", { required: true })}
              defaultValue={item.name}
              isInvalid={formState.errors.name}
            />
          </Form.Group>
          <Form.Group className="mb-3">
            <Form.Label>勘定科目グループ</Form.Label>
            <Form.Select
              {...register("type_id")}
              defaultValue={item.type_id}
              isInvalid={formState.errors.type_id}
            >
              {ACCOUNTING_TYPES.map((type) => (
                <option key={type.key} value={type.id}>
                  {type.label}
                </option>
              ))}
            </Form.Select>
          </Form.Group>
          <Form.Group className="mb-3">
            <Form.Label>説明</Form.Label>
            <Form.Control
              type="text"
              {...register("description")}
              defaultValue={item.description}
              isInvalid={formState.errors.description}
            />
          </Form.Group>
        </Modal.Body>

        <Modal.Footer>
          <Button variant="secondary" onClick={onClose}>
            キャンセル
          </Button>
          <Button variant="primary" type="submit">
            登録
          </Button>
        </Modal.Footer>
      </Form>
    </Modal>
  );
};
