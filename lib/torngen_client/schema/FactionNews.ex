defmodule Torngen.Client.Schema.FactionNews do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :timestamp,
    :text,
    :id
  ]

  @type t :: %__MODULE__{
          timestamp: integer(),
          text: String.t(),
          id: String.t()
        }
end
