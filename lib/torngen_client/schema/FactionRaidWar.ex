defmodule Torngen.Client.Schema.FactionRaidWar do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      war_id: Map.get(data, "war_id") |> Torngen.Client.Schema.parse({:static, :integer}),
      start: Map.get(data, "start") |> Torngen.Client.Schema.parse({:static, :integer}),
      factions:
        Map.get(data, "factions")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionRaidWarParticipant}),
      end: Map.get(data, "end") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
