defmodule Torngen.Client.Schema.HofValue do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :value,
    :rank
  ]

  @type t :: %__MODULE__{
          value: integer(),
          rank: integer()
        }
end
