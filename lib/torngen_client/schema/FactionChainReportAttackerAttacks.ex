defmodule Torngen.Client.Schema.FactionChainReportAttackerAttacks do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      war: Map.get(data, "war") |> Torngen.Client.Schema.parse({:static, :integer}),
      total: Map.get(data, "total") |> Torngen.Client.Schema.parse({:static, :integer}),
      retaliations: Map.get(data, "retaliations") |> Torngen.Client.Schema.parse({:static, :integer}),
      overseas: Map.get(data, "overseas") |> Torngen.Client.Schema.parse({:static, :integer}),
      mug: Map.get(data, "mug") |> Torngen.Client.Schema.parse({:static, :integer}),
      losses: Map.get(data, "losses") |> Torngen.Client.Schema.parse({:static, :integer}),
      leave: Map.get(data, "leave") |> Torngen.Client.Schema.parse({:static, :integer}),
      hospitalize: Map.get(data, "hospitalize") |> Torngen.Client.Schema.parse({:static, :integer}),
      escapes: Map.get(data, "escapes") |> Torngen.Client.Schema.parse({:static, :integer}),
      draws: Map.get(data, "draws") |> Torngen.Client.Schema.parse({:static, :integer}),
      bonuses: Map.get(data, "bonuses") |> Torngen.Client.Schema.parse({:static, :integer}),
      assists: Map.get(data, "assists") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
