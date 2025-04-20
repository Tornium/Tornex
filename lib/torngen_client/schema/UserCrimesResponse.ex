defmodule Torngen.Client.Schema.UserCrimesResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :crimes
  ]

  @type t :: %__MODULE__{
          crimes: Torngen.Client.Schema.UserCrime.t()
        }
end
