defmodule Torngen.Client.Schema.FactionChainReportDetails do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      war: Map.get(data, "war") |> Torngen.Client.Schema.parse({:static, :integer}),
      targets: Map.get(data, "targets") |> Torngen.Client.Schema.parse({:static, :integer}),
      retaliations: Map.get(data, "retaliations") |> Torngen.Client.Schema.parse({:static, :integer}),
      respect: Map.get(data, "respect") |> Torngen.Client.Schema.parse({:static, :number}),
      overseas: Map.get(data, "overseas") |> Torngen.Client.Schema.parse({:static, :integer}),
      mug: Map.get(data, "mug") |> Torngen.Client.Schema.parse({:static, :integer}),
      members: Map.get(data, "members") |> Torngen.Client.Schema.parse({:static, :integer}),
      losses: Map.get(data, "losses") |> Torngen.Client.Schema.parse({:static, :integer}),
      leave: Map.get(data, "leave") |> Torngen.Client.Schema.parse({:static, :integer}),
      hospitalize: Map.get(data, "hospitalize") |> Torngen.Client.Schema.parse({:static, :integer}),
      escapes: Map.get(data, "escapes") |> Torngen.Client.Schema.parse({:static, :integer}),
      draws: Map.get(data, "draws") |> Torngen.Client.Schema.parse({:static, :integer}),
      chain: Map.get(data, "chain") |> Torngen.Client.Schema.parse({:static, :integer}),
      best: Map.get(data, "best") |> Torngen.Client.Schema.parse({:static, :number}),
      assists: Map.get(data, "assists") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
