defmodule Torngen.Client.Schema.FactionHofValues do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :respect,
    :chain_duration,
    :chain
  ]

  @type t :: %__MODULE__{
          respect: nil | integer(),
          chain_duration: nil | integer(),
          chain: nil | integer()
        }
end
