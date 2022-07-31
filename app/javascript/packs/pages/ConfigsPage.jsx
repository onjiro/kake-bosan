import React from "react";
import { ListGroup, ListGroupItem } from "react-bootstrap";
import useItems from "../hooks/useItems";
import useItemModal from "../hooks/useItemModal";
import useAlert from "../hooks/useAlert";
import Footer from "../components/Footer";

export default () => {
  const [ItemModal, openModal] = useItemModal();
  const { items, error } = useItems();
  const { success } = useAlert();

  return (
    <>
      <h3>勘定科目一覧</h3>
      <ListGroup variant="flush">
        {items?.map((item) => (
          <ListGroupItem
            action
            key={item.id}
            onClick={() => openModal(item)}
            className="list-group-item list-group-item-action"
          >
            <div style={{ fontSize: "xx-small" }}>{item.type.name}</div>
            <div className="clearfix">
              <span>{item.name}</span>
              <span className="float-end">
                <span style={{ fontSize: "xx-small" }}>{item.description}</span>
              </span>
            </div>
          </ListGroupItem>
        ))}
      </ListGroup>
      <Footer onClickNewButton={() => openModal()} />

      <ItemModal onSubmit={() => success("棚卸額を登録しました。")} />
    </>
  );
};
