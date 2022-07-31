import useSWR from "swr";
import fetcher from "../utils/fetcher";

const save = async (item) => {
  const { method, url } = item.id
    ? { method: "PATCH", url: `/accounting/items/${item.id}.json` }
    : { method: "POST", url: "/accounting/items.json" };

  return await fetch(url, {
    method: method,
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      id: item.id,
      name: item.name,
      type_id: item.type_id,
      description: item.description,
    }),
  });
};

export { save };

export default (params) => {
  const query = new URLSearchParams(params);
  const { data, error } = useSWR(`/accounting/items.json?${query}`, fetcher);
  return { items: data, error };
};
