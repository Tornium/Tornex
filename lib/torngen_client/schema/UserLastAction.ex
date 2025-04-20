defmodule Torngen.Client.Schema.UserLastAction do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :timestamp,
    :status,
    :relative
  ]

  @type t :: %__MODULE__{
          timestamp: integer(),
          status: String.t(),
          relative: String.t()
        }
end
