defmodule Torngen.Client.Schema.TornItemsResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :items
  ]

  @type t :: %__MODULE__{
          items: [Torngen.Client.Schema.TornItem.t()]
        }
end
