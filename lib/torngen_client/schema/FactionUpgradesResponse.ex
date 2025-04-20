defmodule Torngen.Client.Schema.FactionUpgradesResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :upgrades,
    :state
  ]

  @type t :: %__MODULE__{
          upgrades: Torngen.Client.Schema.FactionUpgrades.t(),
          state: Torngen.Client.Schema.FactionBranchStateEnum.t()
        }
end
