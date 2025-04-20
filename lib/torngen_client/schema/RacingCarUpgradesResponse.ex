defmodule Torngen.Client.Schema.RacingCarUpgradesResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :carupgrades
  ]

  @type t :: %__MODULE__{
          carupgrades: [Torngen.Client.Schema.RaceCarUpgrade.t()]
        }
end
