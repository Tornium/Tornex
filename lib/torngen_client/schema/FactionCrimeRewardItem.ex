defmodule Torngen.Client.Schema.FactionCrimeRewardItem do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :quantity,
    :id
  ]

  @type t :: %__MODULE__{
          quantity: integer(),
          id: Torngen.Client.Schema.ItemId.t()
        }
end
