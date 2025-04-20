defmodule Torngen.Client.Schema.TimestampResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :timestamp
  ]

  @type t :: %__MODULE__{
          timestamp: integer()
        }
end
