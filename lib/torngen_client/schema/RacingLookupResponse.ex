defmodule Torngen.Client.Schema.RacingLookupResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :selections
  ]

  @type t :: %__MODULE__{
          selections: [Torngen.Client.Schema.RacingSelectionName.t()]
        }
end
