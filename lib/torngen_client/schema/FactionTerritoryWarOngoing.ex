defmodule Torngen.Client.Schema.FactionTerritoryWarOngoing do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :territory,
    :target,
    :start,
    :id,
    :factions,
    :end
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          territory: Torngen.Client.Schema.FactionTerritoryEnum.t(),
          target: integer(),
          start: integer(),
          id: Torngen.Client.Schema.TerritoryWarId.t(),
          factions: [Torngen.Client.Schema.FactionTerritoryWarOngoingFaction.t()],
          end: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      territory: Map.get(data, "territory") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionTerritoryEnum),
      target: Map.get(data, "target") |> Torngen.Client.Schema.parse({:static, :integer}),
      start: Map.get(data, "start") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TerritoryWarId),
      factions:
        Map.get(data, "factions")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionTerritoryWarOngoingFaction}),
      end: Map.get(data, "end") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
