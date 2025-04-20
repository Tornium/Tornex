defmodule Torngen.Client.Schema.UserCrimeDetailsCracking do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :highest_mips,
    :encryption_layers_broken,
    :chars_guessed_total,
    :chars_guessed,
    :brute_force_cycles
  ]

  @type t :: %__MODULE__{
          highest_mips: integer(),
          encryption_layers_broken: integer(),
          chars_guessed_total: integer(),
          chars_guessed: integer(),
          brute_force_cycles: integer()
        }
end
