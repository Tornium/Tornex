defmodule Torngen.Client.Schema.TornCrimesResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :crimes
  ]

  @type t :: %__MODULE__{
          crimes: [Torngen.Client.Schema.TornCrime.t()]
        }
end
