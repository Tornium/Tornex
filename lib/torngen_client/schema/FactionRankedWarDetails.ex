defmodule Torngen.Client.Schema.FactionRankedWarDetails do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :winner,
    :target,
    :start,
    :id,
    :factions,
    :end
  ]

  @type t :: %__MODULE__{
          winner: nil | Torngen.Client.Schema.FactionId.t(),
          target: integer(),
          start: integer(),
          id: Torngen.Client.Schema.RankedWarId.t(),
          factions: [
            %{:score => integer(), :name => String.t(), :id => Torngen.Client.Schema.FactionId.t(), :chain => integer()}
          ],
          end: integer()
        }
end
