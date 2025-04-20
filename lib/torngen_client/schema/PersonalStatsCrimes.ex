defmodule Torngen.Client.Schema.PersonalStatsCrimes do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :crimes
  ]

  @type t :: %__MODULE__{
          crimes: Torngen.Client.Schema.PersonalStatsCrimesV2.t() | Torngen.Client.Schema.PersonalStatsCrimesV1.t()
        }
end
