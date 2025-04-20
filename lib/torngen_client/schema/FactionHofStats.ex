defmodule Torngen.Client.Schema.FactionHofStats do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :respect,
    :rank,
    :chain
  ]

  @type t :: %__MODULE__{
          respect: Torngen.Client.Schema.HofValue.t(),
          rank: Torngen.Client.Schema.HofValueString.t(),
          chain: Torngen.Client.Schema.HofValue.t()
        }
end
