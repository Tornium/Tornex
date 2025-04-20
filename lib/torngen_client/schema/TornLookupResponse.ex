defmodule Torngen.Client.Schema.TornLookupResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :selections
  ]

  @type t :: %__MODULE__{
          selections: [Torngen.Client.Schema.TornSelectionName.t()]
        }
end
