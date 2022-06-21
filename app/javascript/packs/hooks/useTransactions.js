import useSWR from "swr";
import fetcher from "../utils/fetcher";

const save = async (transaction) => {
  const response = await fetch(
    transaction.id
      ? `/accounting/transactions/${transaction.id}.json`
      : "/accounting/transactions.json",
    {
      method: transaction.id ? "PATCH" : "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        id: transaction.id,
        date: transaction.date,
        entries_attributes: transaction.entries,
      }),
    }
  );

  return response;
};

const remove = async (transaction) => {
  const response = await fetch(
    `/accounting/transactions/${transaction.id}.json`,
    {
      method: "DELETE",
      headers: { "Content-Type": "application/json" },
    }
  );

  return response;
};
export { save, remove };

export default (params) => {
  const query = new URLSearchParams(params);
  const { data, error, mutate } = useSWR(
    `/accounting/transactions.json?${query}`,
    fetcher
  );
  return { transactions: data, error, mutate };
};
