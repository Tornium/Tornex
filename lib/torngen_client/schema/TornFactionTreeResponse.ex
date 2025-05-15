defmodule Torngen.Client.Schema.TornFactionTreeResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :factionTree
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          factionTree: [Torngen.Client.Schema.TornFactionTree.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      factionTree: Map.get(data, "factionTree")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
