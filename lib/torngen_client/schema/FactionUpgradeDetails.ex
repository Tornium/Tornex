defmodule Torngen.Client.Schema.FactionUpgradeDetails do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :unlocked_at,
    :name,
    :level,
    :id,
    :cost,
    :ability
  ]

  @type t :: %__MODULE__{
          unlocked_at: integer(),
          name: String.t(),
          level: integer(),
          id: Torngen.Client.Schema.FactionBranchId.t(),
          cost: integer(),
          ability: String.t()
        }
end
