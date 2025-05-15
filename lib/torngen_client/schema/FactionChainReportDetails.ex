defmodule Torngen.Client.Schema.FactionChainReportDetails do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :war,
    :targets,
    :retaliations,
    :respect,
    :overseas,
    :mug,
    :members,
    :losses,
    :leave,
    :hospitalize,
    :escapes,
    :draws,
    :chain,
    :best,
    :assists
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          war: integer(),
          targets: integer(),
          retaliations: integer(),
          respect: integer() | float(),
          overseas: integer(),
          mug: integer(),
          members: integer(),
          losses: integer(),
          leave: integer(),
          hospitalize: integer(),
          escapes: integer(),
          draws: integer(),
          chain: integer(),
          best: integer() | float(),
          assists: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      war: Map.get(data, "war"),
      targets: Map.get(data, "targets"),
      retaliations: Map.get(data, "retaliations"),
      respect: Map.get(data, "respect"),
      overseas: Map.get(data, "overseas"),
      mug: Map.get(data, "mug"),
      members: Map.get(data, "members"),
      losses: Map.get(data, "losses"),
      leave: Map.get(data, "leave"),
      hospitalize: Map.get(data, "hospitalize"),
      escapes: Map.get(data, "escapes"),
      draws: Map.get(data, "draws"),
      chain: Map.get(data, "chain"),
      best: Map.get(data, "best"),
      assists: Map.get(data, "assists")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
