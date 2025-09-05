defmodule Tornex.Scheduler.Router do
  @moduledoc """
  Router of queued requests to the node holding the request's respective bucket.

  If there is no cluster present, the router will fallback to local-only operations utilizing the
  current, local node.
  """

  @spec enqueue(query :: Tornex.Query.t() | Tornex.SpecQuery.t(), opts :: keyword()) :: term()
  def enqueue(query, opts \\ [])
  def enqueue(%Tornex.Query{key_owner: key_owner} = query, _opts) when is_integer(key_owner), do: do_enqueue(query)
  def enqueue(%Tornex.SpecQuery{key_owner: key_owner} = query, _opts) when is_integer(key_owner), do: do_enqueue(query)

  defp do_enqueue(query) do
    {:ok, target_node} = Tornex.Scheduler.ClusterRing.user_node(query.key_owner)

    if target_node == node() do
      Tornex.Scheduler.Bucket.enqueue(query)
    else
      :rpc
    end
  end
end
