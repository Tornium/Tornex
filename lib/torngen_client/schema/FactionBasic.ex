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
    :"co-leader_id",
    :capacity,
    :best_chain
  ]

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
          "co-leader_id": Torngen.Client.Schema.UserId.t(),
          capacity: integer(),
          best_chain: integer()
        }
end
