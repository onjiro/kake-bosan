import useSWR from "swr";
import fetcher from "../utils/fetcher";

const save = async (inventory) => {
  const response = await fetch("/accounting/inventories.json", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      date: inventory.date,
      item_id: inventory.item_id,
      amount: inventory.amount,
    }),
  });

  return response;
};

export { save };

export default (params) => {
  const query = new URLSearchParams(params);
  const { data, error, mutate } = useSWR(
    `/accounting/inventories.json?${query}`,
    fetcher
  );
  return { inventories: data, error, mutate };
};
