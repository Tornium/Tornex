defmodule Torngen.Client.Schema.TornTerritoriesResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :territory,
    :_metadata
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          territory: [Torngen.Client.Schema.TornTerritory.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      territory: Map.get(data, "territory"),
      _metadata: Map.get(data, "_metadata")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
