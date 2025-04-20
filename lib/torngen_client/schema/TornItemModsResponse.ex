defmodule Torngen.Client.Schema.TornItemModsResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :itemmods
  ]

  @type t :: %__MODULE__{
          itemmods: [Torngen.Client.Schema.TornItemMods.t()]
        }
end
