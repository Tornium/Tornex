defmodule Torngen.Client.Schema.FactionWars do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :territory,
    :ranked,
    :raids
  ]

  @type t :: %__MODULE__{
          territory: [Torngen.Client.Schema.FactionTerritoryWar.t()],
          ranked: nil | Torngen.Client.Schema.FactionRankedWar.t(),
          raids: [Torngen.Client.Schema.FactionRaidWar.t()]
        }
end
