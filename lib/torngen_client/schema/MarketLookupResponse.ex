defmodule Torngen.Client.Schema.MarketLookupResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :selections
  ]

  @type t :: %__MODULE__{
          selections: [Torngen.Client.Schema.MarketSelectionName.t()]
        }
end
