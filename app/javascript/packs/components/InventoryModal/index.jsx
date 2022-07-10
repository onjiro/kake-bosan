import React from "react";
import { Button, Modal, Form, Row, Col, FormLabel } from "react-bootstrap";
import { useForm } from "react-hook-form";
import { format } from "date-fns/esm";
import useAlert from "../../hooks/useAlert";
import DateInput from "../common/DateInput";
import AmountInput from "../common/AmountInput";
import { save } from "../../hooks/useInventories";

export default ({ inventory, onClose, onSubmit }) => {
  if (!inventory) return null;

  const { register, handleSubmit, watch, setValue, formState } = useForm();
  const { warning, danger } = useAlert();

  const saveInventory = handleSubmit(async (formData, e) => {
    e.preventDefault();

    const _response = await save({
      date: formData.date,
      item_id: formData.item_id,
      amount: formData.amount,
    });

    // TODO エラー時の対応
    onClose();
    onSubmit();
  });

  return (
    <Modal
      show={inventory}
      onHide={onClose}
      backdrop="static"
      keyboard={false}
      fullscreen={true}
    >
      <Form onSubmit={saveInventory}>
        <Modal.Header closeButton>
          <Modal.Title>棚卸額登録 - {inventory.item?.name}</Modal.Title>
        </Modal.Header>

        <Modal.Body>
          <input
            type="hidden"
            defaultValue={inventory.item?.id}
            {...register("item_id")}
          />
          <Row>
            <Col>
              <FormLabel className="mt-3 mb-0">日付</FormLabel>
            </Col>
          </Row>
          <Row className="mb-2">
            <Col>
              <DateInput
                {...register("date", { required: true, valueAsDate: true })}
                defaultValue={format(new Date(inventory.date), "yyyy-MM-dd")}
                isInvalid={formState.errors.date}
              />
            </Col>
            <Col>
              <AmountInput
                {...register("amount", { required: true, valueAsNumber: true })}
                defaultValue={inventory.amount}
                isInvalid={formState.errors.amount}
              />
            </Col>
          </Row>
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
