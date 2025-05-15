defmodule Torngen.Client.Schema.RevivesFullResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :revives,
    :_metadata
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          revives: [Torngen.Client.Schema.ReviveSimplified.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      revives: Map.get(data, "revives"),
      _metadata: Map.get(data, "_metadata")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
