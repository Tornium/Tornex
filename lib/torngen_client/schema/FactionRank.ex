defmodule Torngen.Client.Schema.FactionRank do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :wins,
    :position,
    :name,
    :level,
    :division
  ]

  @type t :: %__MODULE__{
          wins: integer(),
          position: integer(),
          name: String.t(),
          level: integer(),
          division: integer()
        }
end
