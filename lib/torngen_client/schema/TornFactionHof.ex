defmodule Torngen.Client.Schema.TornFactionHof do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :values,
    :rank,
    :position,
    :name,
    :members,
    :faction_id
  ]

  @type t :: %__MODULE__{
          values: Torngen.Client.Schema.FactionHofValues.t(),
          rank: String.t(),
          position: integer(),
          name: String.t(),
          members: integer(),
          faction_id: Torngen.Client.Schema.FactionId.t()
        }
end
