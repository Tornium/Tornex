defmodule Torngen.Client.Schema.UserOrganizedCrimeResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :organizedCrime
  ]

  @type t :: %__MODULE__{
          organizedCrime: nil | Torngen.Client.Schema.FactionCrime.t()
        }
end
