defmodule Torngen.Client.Schema.TornItemArmorDetails do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :coverage,
    :base_stats
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          coverage: [Torngen.Client.Schema.TornItemArmorCoverage.t()],
          base_stats: Torngen.Client.Schema.TornItemBaseStats.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      coverage:
        Map.get(data, "coverage") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.TornItemArmorCoverage}),
      base_stats: Map.get(data, "base_stats") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TornItemBaseStats)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
