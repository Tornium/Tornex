defmodule Torngen.Client.Schema.FactionRankedWar do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :winner,
    :war_id,
    :target,
    :start,
    :factions,
    :end
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          winner: nil | integer(),
          war_id: integer(),
          target: integer(),
          start: integer(),
          factions: [Torngen.Client.Schema.FactionRankedWarParticipant.t()],
          end: nil | integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      winner: Map.get(data, "winner") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]}),
      war_id: Map.get(data, "war_id") |> Torngen.Client.Schema.parse({:static, :integer}),
      target: Map.get(data, "target") |> Torngen.Client.Schema.parse({:static, :integer}),
      start: Map.get(data, "start") |> Torngen.Client.Schema.parse({:static, :integer}),
      factions:
        Map.get(data, "factions")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionRankedWarParticipant}),
      end: Map.get(data, "end") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
