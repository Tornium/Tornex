defmodule Torngen.Client.Schema.FactionCrimeResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :crime
  ]

  @type t :: %__MODULE__{
          crime: Torngen.Client.Schema.FactionCrime.t()
        }
end
