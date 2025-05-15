defmodule Torngen.Client.Schema.TornFactionHofResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :factionhof,
    :_metadata
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          factionhof: [Torngen.Client.Schema.TornFactionHof.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      factionhof: Map.get(data, "factionhof"),
      _metadata: Map.get(data, "_metadata")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
