import { format } from "date-fns/esm";
import React, { useEffect, useState } from "react";
import { Button, Modal, Form, Row, Col, FormLabel } from "react-bootstrap";
import { useForm } from "react-hook-form";
import { BsPlusCircle } from "react-icons/bs";
import ItemSelector from "./ItemSelector";
import useItems from "../../hooks/useItems";
import DateInput from "../common/DateInput";
import AmountInput from "../common/AmountInput";
import { remove, save } from "../../hooks/useTransactions";
import useAlert from "../../hooks/useAlert";

export default ({ transaction, onClose, onSubmit, onDelete }) => {
  const { register, handleSubmit, watch, setValue, formState } = useForm();
  const { items, error } = useItems();
  const { warning, danger } = useAlert();
  useEffect(
    () =>
      error &&
      danger(`設定の取得に失敗しました。リロードしてください。\n${error}`),
    [error]
  );
  if (!transaction || !items) {
    return null;
  }

  const [entries, setEntries] = useState([...transaction.entries]);
  const debits = entries.filter((e) => e.side_id === 1);
  const credits = entries.filter((e) => e.side_id === 2);
  const hasSinglePair = debits.length === 1 && credits.length === 1;

  // 貸借が1対1の場合、自動で貸借をバランスさせる
  useEffect(() => {
    if (!hasSinglePair) {
      return;
    }
    setValue("credits[0].amount", watch("debits[0].amount"));
  }, [watch("debits[0].amount"), hasSinglePair]);

  const saveTransaction = handleSubmit(async (formData, e) => {
    e.preventDefault();
    if (
      formData.debits.reduce((sum, e) => sum + Number(e.amount), 0) !==
      formData.credits.reduce((sum, e) => sum + Number(e.amount), 0)
    ) {
      warning("金額がバランスしていません");
      return;
    }

    if (formData.debits.every((e) => Number(e.amount) === 0)) {
      return;
    }

    const _response = await save({
      id: formData.id ? Number(formData.id) : null,
      date: formData.date,
      entries: formData.debits.concat(formData.credits),
    });
    // TODO エラー時の対応
    onClose();
    onSubmit();
  });

  const deleteTransaction = async () => {
    const _response = await remove(transaction);
    // TODO エラー時の対応
    onClose();
    onDelete();
  };

  return (
    <Modal
      show={transaction}
      onHide={onClose}
      backdrop="static"
      keyboard={false}
      fullscreen={true}
    >
      <Form onSubmit={saveTransaction}>
        <Modal.Header closeButton>
          <Modal.Title>{transaction.id ? "編集" : "新規"}</Modal.Title>
        </Modal.Header>

        <Modal.Body>
          <input
            type="hidden"
            {...register("id")}
            defaultValue={transaction.id}
          />
          <Row className="mb-2 row-cols-1 row-cols-md-2">
            <Col>
              <FormLabel className="mt-3 mb-0">日付</FormLabel>
              <DateInput
                {...register("date", { required: true, valueAsDate: true })}
                defaultValue={format(new Date(transaction.date), "yyyy-MM-dd")}
                isInvalid={formState.errors.date}
              />
            </Col>
          </Row>

          <Row className="mb-4 row-cols-1 row-cols-md-2">
            <Col>
              <FormLabel className="mt-3 mb-1">
                借方{" "}
                <a
                  href="#"
                  onClick={(e) => {
                    e.preventDefault();
                    setEntries([...entries, { side_id: 1, amount: 0 }]);
                  }}
                >
                  <BsPlusCircle></BsPlusCircle>
                </a>
              </FormLabel>
              {debits.map((e, index) => {
                return (
                  <Row key={index}>
                    <input
                      type="hidden"
                      {...register(`debits[${index}].side_id`)}
                      defaultValue={e.side_id}
                    />
                    <Col className="col-8">
                      <ItemSelector
                        placeholder="【借方】"
                        items={items}
                        initialFilter="費用"
                        {...register(`debits[${index}].item_id`, {
                          required: true,
                        })}
                        defaultValue={e.item_id}
                        isInvalid={formState.errors.debits?.[index]?.item_id}
                      />
                    </Col>
                    <Col className="col-4">
                      <AmountInput
                        {...register(`debits[${index}].amount`, {
                          required: true,
                          valueAsNumber: true,
                        })}
                        defaultValue={e.amount}
                        isInvalid={formState.errors.debits?.[index]?.amount}
                      />
                    </Col>
                  </Row>
                );
              })}
            </Col>

            <Col>
              <FormLabel className="mt-3 mb-1">
                貸方{" "}
                <a
                  href="#"
                  onClick={(e) => {
                    e.preventDefault();
                    setEntries([...entries, { side_id: 2, amount: 0 }]);
                  }}
                >
                  <BsPlusCircle></BsPlusCircle>
                </a>
              </FormLabel>
              {credits.map((e, index) => {
                return (
                  <Row key={index}>
                    <input
                      type="hidden"
                      {...register(`credits[${index}].side_id`)}
                      defaultValue={e.side_id}
                    />
                    <Col className="col-8">
                      <ItemSelector
                        placeholder="【貸方】"
                        items={items}
                        initialFilter="資産, 負債"
                        {...register(`credits[${index}].item_id`, {
                          required: true,
                        })}
                        defaultValue={e.item_id}
                        isInvalid={formState.errors.credits?.[index]?.item_id}
                      />
                    </Col>
                    <Col className="col-4">
                      <AmountInput
                        {...register(`credits[${index}].amount`, {
                          required: true,
                          valueAsNumber: true,
                        })}
                        defaultValue={e.amount}
                        disabled={hasSinglePair}
                        isInvalid={formState.errors.credits?.[index]?.amount}
                      />
                    </Col>
                  </Row>
                );
              })}
            </Col>
          </Row>

          {transaction.id ? (
            <div className="d-grid gap-2">
              <Button variant="danger" onClick={deleteTransaction}>
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
