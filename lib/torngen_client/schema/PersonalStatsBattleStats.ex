defmodule Torngen.Client.Schema.PersonalStatsBattleStats do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :battle_stats
  ]

  @type t :: %__MODULE__{
          battle_stats: %{
            :total => integer(),
            :strength => integer(),
            :speed => integer(),
            :dexterity => integer(),
            :defense => integer()
          }
        }
end
