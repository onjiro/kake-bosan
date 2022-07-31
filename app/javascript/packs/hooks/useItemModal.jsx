import React, { useCallback, useState } from "react";
import ItemModal from "../components/ItemModal";

export default () => {
  const [item, setItem] = useState(null);
  const open = (item) => setItem(item);
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
