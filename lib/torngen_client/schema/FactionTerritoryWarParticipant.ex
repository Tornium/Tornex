defmodule Torngen.Client.Schema.FactionTerritoryWarParticipant do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :score,
    :playerIds,
    :name,
    :is_aggressor,
    :id,
    :chain
  ]

  @type t :: %__MODULE__{
          score: integer(),
          playerIds: [Torngen.Client.Schema.UserId.t()],
          name: String.t(),
          is_aggressor: boolean(),
          id: Torngen.Client.Schema.FactionId.t(),
          chain: integer()
        }
end
