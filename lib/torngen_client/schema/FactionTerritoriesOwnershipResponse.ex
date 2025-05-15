defmodule Torngen.Client.Schema.FactionTerritoriesOwnershipResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :territoryownership
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          territoryownership: [Torngen.Client.Schema.FactionTerritoryOwnership.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      territoryownership: Map.get(data, "territoryownership")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
