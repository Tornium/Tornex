defmodule Torngen.Client.Schema.ForumLookupResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :selections
  ]

  @type t :: %__MODULE__{
          selections: [Torngen.Client.Schema.ForumSelectionName.t()]
        }
end
