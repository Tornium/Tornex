defmodule Torngen.Client.Schema.FactionTerritoryWarReport do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :winner,
    :territory,
    :started_at,
    :result,
    :id,
    :factions,
    :ended_at
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          winner: Torngen.Client.Schema.FactionId.t(),
          territory: Torngen.Client.Schema.FactionTerritoryEnum.t(),
          started_at: integer(),
          result: String.t(),
          id: Torngen.Client.Schema.TerritoryWarId.t(),
          factions: [Torngen.Client.Schema.FactionTerritoryWarReportFaction.t()],
          ended_at: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      winner: Map.get(data, "winner") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionId),
      territory: Map.get(data, "territory") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionTerritoryEnum),
      started_at: Map.get(data, "started_at") |> Torngen.Client.Schema.parse({:static, :integer}),
      result: Map.get(data, "result") |> Torngen.Client.Schema.parse({:static, :string}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TerritoryWarId),
      factions:
        Map.get(data, "factions")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionTerritoryWarReportFaction}),
      ended_at: Map.get(data, "ended_at") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
