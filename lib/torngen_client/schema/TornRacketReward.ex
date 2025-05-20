defmodule Torngen.Client.Schema.TornRacketReward do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :type,
    :quantity,
    :id
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          type: Torngen.Client.Schema.TornRacketType.t(),
          quantity: integer(),
          id: nil | Torngen.Client.Schema.ItemId.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      type: Map.get(data, "type") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TornRacketType),
      quantity: Map.get(data, "quantity") |> Torngen.Client.Schema.parse({:static, :integer}),
      id:
        Map.get(data, "id") |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.ItemId]})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
