defmodule Torngen.Client.Schema.RacingCarsResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :cars
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          cars: [Torngen.Client.Schema.RaceCar.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      cars: Map.get(data, "cars")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
