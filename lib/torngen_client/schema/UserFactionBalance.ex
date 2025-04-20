defmodule Torngen.Client.Schema.UserFactionBalance do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :points,
    :money
  ]

  @type t :: %__MODULE__{
          points: integer(),
          money: integer()
        }
end
