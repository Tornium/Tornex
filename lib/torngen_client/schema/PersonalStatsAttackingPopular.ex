defmodule Torngen.Client.Schema.PersonalStatsAttackingPopular do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :attacking
  ]

  @type t :: %__MODULE__{
          attacking: %{
            :networth => %{:money_mugged => integer(), :largest_mug => integer(), :items_looted => integer()},
            :killstreak => %{:best => integer()},
            :hits => %{:success => integer(), :one_hit_kills => integer(), :miss => integer(), :critical => integer()},
            :faction => %{:respect => integer(), :ranked_war_hits => integer()},
            :escapes => %{:player => integer(), :foes => integer()},
            :elo => integer(),
            :defends => %{:won => integer(), :stalemate => integer(), :lost => integer()},
            :damage => %{:total => integer(), :best => integer()},
            :attacks => %{:won => integer(), :stalemate => integer(), :lost => integer(), :assist => integer()},
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
