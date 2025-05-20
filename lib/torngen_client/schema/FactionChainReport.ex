defmodule Torngen.Client.Schema.FactionChainReport do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :start,
    :non_attackers,
    :"non-attackers",
    :id,
    :faction_id,
    :end,
    :details,
    :bonuses,
    :attackers
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          start: integer(),
          non_attackers: [Torngen.Client.Schema.UserId.t()],
          "non-attackers": [Torngen.Client.Schema.UserId.t()],
          id: Torngen.Client.Schema.ChainId.t(),
          faction_id: Torngen.Client.Schema.FactionId.t(),
          end: integer(),
          details: Torngen.Client.Schema.FactionChainReportDetails.t(),
          bonuses: [Torngen.Client.Schema.FactionChainReportBonus.t()],
          attackers: [Torngen.Client.Schema.FactionChainReportAttacker.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      start: Map.get(data, "start") |> Torngen.Client.Schema.parse({:static, :integer}),
      non_attackers:
        Map.get(data, "non_attackers") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.UserId}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ChainId),
      faction_id: Map.get(data, "faction_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionId),
      end: Map.get(data, "end") |> Torngen.Client.Schema.parse({:static, :integer}),
      details: Map.get(data, "details") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionChainReportDetails),
      bonuses:
        Map.get(data, "bonuses") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionChainReportBonus}),
      attackers:
        Map.get(data, "attackers")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionChainReportAttacker})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
