defmodule Torngen.Client.Schema.TornItemModsResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :itemmods
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          itemmods: [Torngen.Client.Schema.TornItemMods.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      itemmods: Map.get(data, "itemmods")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
