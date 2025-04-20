defmodule Torngen.Client.Schema.FactionLookupResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :selections
  ]

  @type t :: %__MODULE__{
          selections: [Torngen.Client.Schema.FactionSelectionName.t()]
        }
end
