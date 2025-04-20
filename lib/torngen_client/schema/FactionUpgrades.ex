defmodule Torngen.Client.Schema.FactionUpgrades do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :war,
    :peace,
    :core
  ]

  @type t :: %__MODULE__{
          war: [Torngen.Client.Schema.FactionBranchDetails.t()],
          peace: [Torngen.Client.Schema.FactionBranchDetails.t()],
          core: %{:upgrades => [Torngen.Client.Schema.FactionUpgradeDetails.t()]}
        }
end
