import React, { useCallback, useState } from "react";
import ItemModal from "../components/ItemModal";
import ACCOUNTING_TYPES from "../utils/accountingTypes";

export default () => {
  const [item, setItem] = useState(null);
  const open = (item) => {
    setItem(
      item || {
        id: null,
        name: "",
        type_id: ACCOUNTING_TYPES[0]["id"],
        description: "",
      }
    );
  };
  const close = () => setItem(null);
  const isOpen = () => !!item;

  const ModalWrapper = useCallback(
    (props) => {
      return <ItemModal item={item} onClose={close} {...props} />;
    },
    [item]
  );

  return [ModalWrapper, open, close, isOpen];
};
