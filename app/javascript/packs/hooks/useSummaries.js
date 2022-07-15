import useSWR from "swr";
import fetcher from "../utils/fetcher";

export default (params) => {
  const query = new URLSearchParams(params);
  const { data, error, mutate } = useSWR(
    `/accounting/summaries.json?${query}`,
    fetcher
  );
  return { summaries: data, error, mutate };
};
