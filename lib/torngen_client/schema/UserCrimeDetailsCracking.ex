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

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          highest_mips: integer(),
          encryption_layers_broken: integer(),
          chars_guessed_total: integer(),
          chars_guessed: integer(),
          brute_force_cycles: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      highest_mips: Map.get(data, "highest_mips"),
      encryption_layers_broken: Map.get(data, "encryption_layers_broken"),
      chars_guessed_total: Map.get(data, "chars_guessed_total"),
      chars_guessed: Map.get(data, "chars_guessed"),
      brute_force_cycles: Map.get(data, "brute_force_cycles")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
