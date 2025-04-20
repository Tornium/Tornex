defmodule Torngen.Client.Schema.PersonalStatsAttackingPublic do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :attacking
  ]

  @type t :: %__MODULE__{
          attacking: %{
            :unarmored_wins => integer(),
            :networth => %{:money_mugged => integer(), :largest_mug => integer(), :items_looted => integer()},
            :killstreak => %{:best => integer()},
            :hits => %{:success => integer(), :one_hit_kills => integer(), :miss => integer(), :critical => integer()},
            :highest_level_beaten => integer(),
            :faction => %{
              :territory => %{:wall_time => integer(), :wall_joins => integer(), :wall_clears => integer()},
              :retaliations => integer(),
              :respect => integer(),
              :ranked_war_hits => integer(),
              :raid_hits => integer()
            },
            :escapes => %{:player => integer(), :foes => integer()},
            :elo => integer(),
            :defends => %{:won => integer(), :total => integer(), :stalemate => integer(), :lost => integer()},
            :damage => %{:total => integer(), :best => integer()},
            :attacks => %{
              :won => integer(),
              :stealth => integer(),
              :stalemate => integer(),
              :lost => integer(),
              :assist => integer()
            },
            :ammunition => %{
              :tracer => integer(),
              :total => integer(),
              :special => integer(),
              :piercing => integer(),
              :incendiary => integer(),
              :hollow_point => integer()
            }
          }
        }
end
