defmodule Torngen.Client.Schema.TornSubcrimesResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :subcrimes
  ]

  @type t :: %__MODULE__{
          subcrimes: [Torngen.Client.Schema.TornSubcrime.t()]
        }
end
