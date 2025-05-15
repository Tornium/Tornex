defmodule Torngen.Client.Schema.FactionChainReportAttackerRespect do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :total,
    :best,
    :average
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          total: integer() | float(),
          best: integer() | float(),
          average: integer() | float()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      total: Map.get(data, "total"),
      best: Map.get(data, "best"),
      average: Map.get(data, "average")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
