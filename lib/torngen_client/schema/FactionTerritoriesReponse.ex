defmodule Torngen.Client.Schema.FactionTerritoriesReponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :territory
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          territory: [Torngen.Client.Schema.FactionTerritory.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      territory: Map.get(data, "territory")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
