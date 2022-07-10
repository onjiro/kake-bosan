import { format } from "date-fns";
import React from "react";
import { ListGroup, ListGroupItem, Row } from "react-bootstrap";
import useAlert from "../hooks/useAlert";
import useInventories from "../hooks/useInventories";
import useInventoryModal from "../hooks/useInventoryModal";

export default () => {
  const [InventoryModal, openModal] = useInventoryModal();
  const { success } = useAlert();

  const { inventories, error } = useInventories({
    date: format(new Date(), "yyyy-MM-dd"),
  });
  const assetInventories =
    inventories?.filter(({ item }) => item.type_id === 1) || [];
  const liabilityInventories =
    inventories?.filter(({ item }) => item.type_id === 3) || [];

  return (
    <>
      <Row>
        <h3>棚卸高</h3>
        <ListGroup variant="flush">
          {[...assetInventories, ...liabilityInventories].map((i) => (
            <ListGroupItem
              key={i.item.id}
              onClick={() =>
                openModal({
                  date: format(new Date(), "yyyy-MM-dd"),
                  amount: i.amount,
                  item: i.item,
                })
              }
              className="list-group-item list-group-item-action"
            >
              <div className="clearfix">
                <span>{i.item.name}</span>
                <span className="float-end">
                  <span>&yen;{i.amount}</span>
                </span>
              </div>
            </ListGroupItem>
          ))}
        </ListGroup>
      </Row>

      <InventoryModal onSubmit={() => success("棚卸額を登録しました。")} />
    </>
  );
};
