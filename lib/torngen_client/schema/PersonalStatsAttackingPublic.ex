defmodule Torngen.Client.Schema.PersonalStatsAttackingPublic do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :attacking
  ]

  # TODO: Handle required values in schema parser
  @required []
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

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      attacking: Map.get(data, "attacking")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
