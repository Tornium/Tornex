defmodule Tornex.Scheduler.ClusterRing do
  @moduledoc """
  Hash ring used to lookup the node associated with a user's bucket.
  """

  @doc """
  Get the node containing the ratelimiting bucket associated with a user.
  """
  @spec user_node(user_id :: integer()) :: {:ok, node()} | {:error, atom()}
  def user_node(user_id) when is_integer(user_id) do
    found_node = ExHashRing.Ring.find_node(Tornex.Scheduler.Ring, user_id)

    case found_node do
      {:ok, node} -> {:ok, String.to_atom(node)}
      {:error, _} -> found_node
    end
  end

  @spec node_connected(node :: node()) :: {:ok, [ExHashRing.Node.t()]} | {:error, :node_exists}
  def node_connected(node) when is_atom(node) do
    added_node = ExHashRing.Ring.add_node(Tornex.Scheduler.Ring, node |> Atom.to_string())

    case added_node do
      {:ok, _} -> nil
      {:error, :node_exists} -> added_node
    end
  end

  @spec node_disconnected(node :: node()) :: {:ok, [ExHashRing.Node.t()]} | {:error, :node_not_exists}
  def node_disconnected(node) when is_atom(node) do
    removed_node = ExHashRing.Ring.remove_node(Tornex.Scheduler.Ring, node |> Atom.to_string())

    case removed_node do
      {:ok, _} -> nil
      {:error, :node_not_exists} -> removed_node
    end
  end
end
