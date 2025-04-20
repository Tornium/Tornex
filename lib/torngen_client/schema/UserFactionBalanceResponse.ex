defmodule Torngen.Client.Schema.UserFactionBalanceResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :factionBalance
  ]

  @type t :: %__MODULE__{
          factionBalance: nil | Torngen.Client.Schema.UserFactionBalance.t()
        }
end
