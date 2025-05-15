defmodule Torngen.Client.Schema.ItemMarketListingItemStats do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :quality,
    :damage,
    :armor,
    :accuracy
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          quality: integer() | float(),
          damage: nil | integer() | float(),
          armor: nil | integer() | float(),
          accuracy: nil | integer() | float()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      quality: Map.get(data, "quality"),
      damage: Map.get(data, "damage"),
      armor: Map.get(data, "armor"),
      accuracy: Map.get(data, "accuracy")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
