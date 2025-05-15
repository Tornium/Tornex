defmodule Torngen.Client.Schema.TornItemArmorDetails do
  @moduledoc """
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
      coverage: Map.get(data, "coverage"),
      base_stats: Map.get(data, "base_stats")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
