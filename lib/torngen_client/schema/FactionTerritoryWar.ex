defmodule Torngen.Client.Schema.FactionTerritoryWar do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :winner,
    :war_id,
    :territory,
    :target,
    :start,
    :factions,
    :end
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          winner: nil | Torngen.Client.Schema.FactionId.t(),
          war_id: integer(),
          territory: String.t(),
          target: integer(),
          start: integer(),
          factions: [Torngen.Client.Schema.FactionTerritoryWarParticipant.t()],
          end: nil | integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      winner:
        Map.get(data, "winner")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.FactionId]}),
      war_id: Map.get(data, "war_id") |> Torngen.Client.Schema.parse({:static, :integer}),
      territory: Map.get(data, "territory") |> Torngen.Client.Schema.parse({:static, :string}),
      target: Map.get(data, "target") |> Torngen.Client.Schema.parse({:static, :integer}),
      start: Map.get(data, "start") |> Torngen.Client.Schema.parse({:static, :integer}),
      factions:
        Map.get(data, "factions")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionTerritoryWarParticipant}),
      end: Map.get(data, "end") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
