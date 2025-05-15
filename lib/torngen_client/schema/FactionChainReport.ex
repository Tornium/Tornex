defmodule Torngen.Client.Schema.FactionChainReport do
  @moduledoc """
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
      start: Map.get(data, "start"),
      non_attackers: Map.get(data, "non_attackers"),
      id: Map.get(data, "id"),
      faction_id: Map.get(data, "faction_id"),
      end: Map.get(data, "end"),
      details: Map.get(data, "details"),
      bonuses: Map.get(data, "bonuses"),
      attackers: Map.get(data, "attackers")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
