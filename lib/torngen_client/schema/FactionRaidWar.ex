defmodule Torngen.Client.Schema.FactionRaidWar do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :war_id,
    :start,
    :factions,
    :end
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          war_id: integer(),
          start: integer(),
          factions: [Torngen.Client.Schema.FactionRaidWarParticipant.t()],
          end: nil | integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      war_id: Map.get(data, "war_id"),
      start: Map.get(data, "start"),
      factions: Map.get(data, "factions"),
      end: Map.get(data, "end")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
