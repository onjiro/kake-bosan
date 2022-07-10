import React, { useCallback, useState } from "react";
import InventoryModal from "../components/InventoryModal";

export default () => {
  const [inventory, setInventory] = useState(null);
  const open = (inventory) => setInventory(inventory);
  const close = () => setInventory(null);
  const isOpen = () => !!transaction;

  const ModalWrapper = useCallback(
    (props) => {
      return (
        <InventoryModal inventory={inventory} onClose={close} {...props} />
      );
    },
    [inventory]
  );

  return [ModalWrapper, open, close, isOpen];
};
