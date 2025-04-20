defmodule Torngen.Client.Schema.RacingCarsResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :cars
  ]

  @type t :: %__MODULE__{
          cars: [Torngen.Client.Schema.RaceCar.t()]
        }
end
