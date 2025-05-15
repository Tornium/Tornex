defmodule Torngen.Client.Schema.FactionStatsResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :stats
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          stats: [Torngen.Client.Schema.FactionStat.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      stats: Map.get(data, "stats")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
