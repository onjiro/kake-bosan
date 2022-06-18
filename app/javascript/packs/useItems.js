import useSWR from "swr";
import fetcher from "./fetcher";

export default (params) => {
  const query = new URLSearchParams(params);
  const { data, error } = useSWR(`/accounting/items.json?${query}`, fetcher);
  return { items: data, error };
};
