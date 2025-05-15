defmodule Torngen.Client.Schema.FactionBasic do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :tag_image,
    :tag,
    :respect,
    :rank,
    :name,
    :members,
    :leader_id,
    :is_enlisted,
    :id,
    :days_old,
    :co_leader_id,
    :"co-leader_id",
    :capacity,
    :best_chain
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          tag_image: String.t(),
          tag: String.t(),
          respect: integer(),
          rank: Torngen.Client.Schema.FactionRank.t(),
          name: String.t(),
          members: integer(),
          leader_id: Torngen.Client.Schema.UserId.t(),
          is_enlisted: nil | boolean(),
          id: Torngen.Client.Schema.FactionId.t(),
          days_old: integer(),
          co_leader_id: Torngen.Client.Schema.UserId.t(),
          "co-leader_id": Torngen.Client.Schema.UserId.t(),
          capacity: integer(),
          best_chain: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      tag_image: Map.get(data, "tag_image"),
      tag: Map.get(data, "tag"),
      respect: Map.get(data, "respect"),
      rank: Map.get(data, "rank"),
      name: Map.get(data, "name"),
      members: Map.get(data, "members"),
      leader_id: Map.get(data, "leader_id"),
      is_enlisted: Map.get(data, "is_enlisted"),
      id: Map.get(data, "id"),
      days_old: Map.get(data, "days_old"),
      co_leader_id: Map.get(data, "co_leader_id"),
      capacity: Map.get(data, "capacity"),
      best_chain: Map.get(data, "best_chain")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
