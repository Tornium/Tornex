defmodule Torngen.Client.Schema.FactionOngoingChainResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :chain
  ]

  @type t :: %__MODULE__{
          chain: Torngen.Client.Schema.FactionOngoingChain.t()
        }
end
