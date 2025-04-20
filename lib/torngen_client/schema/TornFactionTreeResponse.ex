defmodule Torngen.Client.Schema.TornFactionTreeResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :factionTree
  ]

  @type t :: %__MODULE__{
          factionTree: Torngen.Client.Schema.TornFactionTree.t()
        }
end
