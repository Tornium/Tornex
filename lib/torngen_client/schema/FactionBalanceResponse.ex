defmodule Torngen.Client.Schema.FactionBalanceResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :balance
  ]

  @type t :: %__MODULE__{
          balance: Torngen.Client.Schema.FactionBalance.t()
        }
end
