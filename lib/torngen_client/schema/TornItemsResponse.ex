defmodule Torngen.Client.Schema.TornItemsResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :items
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          items: [Torngen.Client.Schema.TornItem.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      items: Map.get(data, "items") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.TornItem})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
