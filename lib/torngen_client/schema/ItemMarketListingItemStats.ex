defmodule Torngen.Client.Schema.ItemMarketListingItemStats do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      quality: Map.get(data, "quality") |> Torngen.Client.Schema.parse({:static, :number}),
      damage: Map.get(data, "damage") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :number]}),
      armor: Map.get(data, "armor") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :number]}),
      accuracy: Map.get(data, "accuracy") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :number]})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
