defmodule Torngen.Client.Schema.TornHofResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :hof,
    :_metadata
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          hof: [Torngen.Client.Schema.TornHof.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      hof: Map.get(data, "hof"),
      _metadata: Map.get(data, "_metadata")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
