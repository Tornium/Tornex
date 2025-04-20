defmodule Torngen.Client.Schema.FactionChain do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :start,
    :respect,
    :id,
    :end,
    :chain
  ]

  @type t :: %__MODULE__{
          start: integer(),
          respect: integer() | float(),
          id: Torngen.Client.Schema.ChainId.t(),
          end: integer(),
          chain: integer()
        }
end
