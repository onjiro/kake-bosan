import useSWR from "swr";
import fetcher from "../utils/fetcher";

export default (params) => {
  const query = new URLSearchParams(params);
  const { data, error, mutate } = useSWR(
    `/accounting/inventories.json?${query}`,
    fetcher
  );
  return { inventories: data, error, mutate };
};
