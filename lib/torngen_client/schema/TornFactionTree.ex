defmodule Torngen.Client.Schema.TornFactionTree do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :name,
    :branches
  ]

  @type t :: %__MODULE__{
          name: String.t(),
          branches: [Torngen.Client.Schema.TornFactionTreeBranch.t()]
        }
end
