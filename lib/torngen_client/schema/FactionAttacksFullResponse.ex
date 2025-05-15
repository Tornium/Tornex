defmodule Torngen.Client.Schema.FactionAttacksFullResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :attacks,
    :_metadata
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          attacks: [Torngen.Client.Schema.AttackSimplified.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      attacks: Map.get(data, "attacks"),
      _metadata: Map.get(data, "_metadata")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
