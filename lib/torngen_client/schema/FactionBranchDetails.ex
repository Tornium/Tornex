defmodule Torngen.Client.Schema.FactionBranchDetails do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :upgrades,
    :order,
    :name,
    :multiplier
  ]

  @type t :: %__MODULE__{
          upgrades: [Torngen.Client.Schema.FactionUpgradeDetails.t()],
          order: integer(),
          name: String.t(),
          multiplier: integer()
        }
end
