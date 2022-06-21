import { format } from "date-fns/esm";
import React, { useMemo, useEffect } from "react";
import { Button, Modal, Form, InputGroup, Row } from "react-bootstrap";
import { useForm } from "react-hook-form";
import { BsClock } from "react-icons/bs";
import ItemSelector from "./ItemSelector";
import useItems from "../../hooks/useItems";
import { remove, save } from "../../hooks/useTransactions";
import DateInput from "./DateInput";
import AmountInput from "./AmountInput";

export default ({ transaction, onClose, onSubmit, onDelete }) => {
  const { register, handleSubmit, watch, setValue, formState } = useForm();
  const { items, error } = useItems();
  useEffect(
    () =>
      error &&
      danger(`設定の取得に失敗しました。リロードしてください。\n${error}`),
    [error]
  );

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

  const saveTransaction = handleSubmit(async (formData) => {
    console.log(formData);
    formData.debits = formData.debits.filter((e) => e.item_id);
    formData.credits = formData.credits.filter((e) => e.item_id);
    const debitSum = formData.debits.reduce(
      (sum, e) => sum + Number(e.amount),
      0
    );
    const creditSum = formData.credits.reduce(
      (sum, e) => sum + Number(e.amount),
      0
    );
    if (debitSum !== creditSum || debitSum === 0 || creditSum === 0) {
      console.log("合計額がダメ", debitSum, creditSum);
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

  const hasSinglePair = useMemo(
    () => debits.length === 1 && credits.length === 1,
    [debits, credits]
  );
  // 貸借が1対1の場合、自動で貸借をバランスさせる
  useEffect(() => {
    if (!hasSinglePair) {
      return;
    }
    setValue("credits[0].amount", watch("debits[0].amount"));
  }, [watch("debits[0].amount"), hasSinglePair]);

  useEffect(() => console.log(formState.errors), [formState]);
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
          <Row className="mb-2">
            <DateInput
              type="date"
              {...register("date", { required: true, valueAsDate: true })}
              defaultValue={format(new Date(transaction.date), "yyyy-MM-dd")}
              isInvalid={formState.errors.date}
            />
          </Row>

          <Row className="mb-2">
            {debits.map((e, index) => {
              return (
                <div key={index}>
                  <input
                    type="hidden"
                    {...register(`debits[${index}].side_id`)}
                    defaultValue={e.side_id}
                  />
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
                  <AmountInput
                    type="number"
                    className="text-end"
                    {...register(`debits[${index}].amount`, {
                      required: true,
                      validate: {
                        nonzero: (v) => parseInt(v, 10) !== 0,
                      },
                    })}
                    defaultValue={e.amount}
                    isInvalid={formState.errors.debits?.[index]?.amount}
                  />
                </div>
              );
            })}

            {credits.map((e, index) => {
              return (
                <div key={index}>
                  <input
                    type="hidden"
                    {...register(`credits[${index}].side_id`)}
                    defaultValue={e.side_id}
                  />
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
                  <AmountInput
                    type="number"
                    className="text-end"
                    {...register(`credits[${index}].amount`, {
                      required: true,
                      validate: {
                        nonzero: (v) => parseInt(v, 10) !== 0,
                      },
                    })}
                    defaultValue={e.amount}
                    disabled={hasSinglePair}
                    isInvalid={formState.errors.credits?.[index]?.amount}
                  />
                </div>
              );
            })}
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
