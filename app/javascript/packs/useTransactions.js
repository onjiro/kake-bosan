import useSWR from "swr";
import fetcher from "./fetcher";

export default (params) => {
  const query = new URLSearchParams(params);
  const { data, error, mutate } = useSWR(
    `/accounting/transactions.json?${query}`,
    fetcher
  );
  return { transactions: data, error, mutate };
};
