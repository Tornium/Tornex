defmodule Torngen.Client.Schema.PersonalStatsHistoricStat do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :value,
    :timestamp,
    :name
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          value: integer(),
          timestamp: integer(),
          name: String.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      value: Map.get(data, "value"),
      timestamp: Map.get(data, "timestamp"),
      name: Map.get(data, "name")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
