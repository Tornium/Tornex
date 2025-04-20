defmodule Torngen.Client.Schema.FactionPositionsResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :positions
  ]

  @type t :: %__MODULE__{
          positions: [Torngen.Client.Schema.FactionPosition.t()]
        }
end
