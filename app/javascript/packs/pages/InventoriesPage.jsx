import { format } from "date-fns";
import { addDays } from "date-fns/esm";
import React, { useCallback } from "react";
import { ListGroup, ListGroupItem, Row } from "react-bootstrap";
import useInventories from "../hooks/useInventories";

export default () => {
  const tomorrow = addDays(new Date(), 1);
  const { inventories, error } = useInventories({
    date: format(tomorrow, "yyyy-MM-dd"),
  });
  const assetInventories =
    inventories?.filter(({ item }) => item.type_id === 1) || [];
  const liabilityInventories =
    inventories?.filter(({ item }) => item.type_id === 3) || [];
  const showDetail = useCallback((inentory) => {
    /* TODO */
  }, []);

  return (
    <>
      <Row>
        <h3>棚卸高</h3>
        <ListGroup variant="flush">
          {[...assetInventories, ...liabilityInventories].map((i) => (
            <ListGroupItem
              key={i.item.id}
              onClick={() => showDetail(i)}
              className="list-group-item list-group-item-action"
            >
              <div className="clearfix">
                <span>{i.item.name}</span>
                <span className="float-end">
                  <span style={{ fontSize: "larger" }}>&yen;{i.amount}</span>
                </span>
              </div>
            </ListGroupItem>
          ))}
        </ListGroup>
      </Row>
    </>
  );
};
