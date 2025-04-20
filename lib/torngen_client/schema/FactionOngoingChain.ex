defmodule Torngen.Client.Schema.FactionOngoingChain do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :timeout,
    :start,
    :modifier,
    :max,
    :id,
    :end,
    :current,
    :cooldown
  ]

  @type t :: %__MODULE__{
          timeout: integer(),
          start: integer(),
          modifier: integer() | float(),
          max: integer(),
          id: Torngen.Client.Schema.ChainId.t(),
          end: integer(),
          current: integer(),
          cooldown: integer()
        }
end
