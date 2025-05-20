defmodule Torngen.Client.Schema.TornTerritoryCoordinates do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :y,
    :x
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          y: integer() | float(),
          x: integer() | float()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      y: Map.get(data, "y") |> Torngen.Client.Schema.parse({:static, :number}),
      x: Map.get(data, "x") |> Torngen.Client.Schema.parse({:static, :number})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
