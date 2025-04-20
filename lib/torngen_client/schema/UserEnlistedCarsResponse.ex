defmodule Torngen.Client.Schema.UserEnlistedCarsResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :enlistedcars
  ]

  @type t :: %__MODULE__{
          enlistedcars: [Torngen.Client.Schema.UserRaceCarDetails.t()]
        }
end
