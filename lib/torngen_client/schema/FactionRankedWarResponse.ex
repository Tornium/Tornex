defmodule Torngen.Client.Schema.FactionRankedWarResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :rankedwars,
    :_metadata
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          rankedwars: [Torngen.Client.Schema.FactionRankedWarDetails.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      rankedwars: Map.get(data, "rankedwars"),
      _metadata: Map.get(data, "_metadata")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
