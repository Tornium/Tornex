defmodule Torngen.Client.Schema.FactionChainReportAttackerAttacks do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :war,
    :total,
    :retaliations,
    :overseas,
    :mug,
    :losses,
    :leave,
    :hospitalize,
    :escapes,
    :draws,
    :bonuses,
    :assists
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          war: integer(),
          total: integer(),
          retaliations: integer(),
          overseas: integer(),
          mug: integer(),
          losses: integer(),
          leave: integer(),
          hospitalize: integer(),
          escapes: integer(),
          draws: integer(),
          bonuses: integer(),
          assists: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      war: Map.get(data, "war"),
      total: Map.get(data, "total"),
      retaliations: Map.get(data, "retaliations"),
      overseas: Map.get(data, "overseas"),
      mug: Map.get(data, "mug"),
      losses: Map.get(data, "losses"),
      leave: Map.get(data, "leave"),
      hospitalize: Map.get(data, "hospitalize"),
      escapes: Map.get(data, "escapes"),
      draws: Map.get(data, "draws"),
      bonuses: Map.get(data, "bonuses"),
      assists: Map.get(data, "assists")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
