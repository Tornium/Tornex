defmodule Torngen.Client.Schema.HofValueString do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :value,
    :rank
  ]

  @type t :: %__MODULE__{
          value: String.t(),
          rank: integer()
        }
end
