defmodule Torngen.Client.Schema.PersonalStatsAttackingPublic do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      attacking:
        Map.get(data, "attacking")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "ammunition" =>
               {:object,
                %{
                  "hollow_point" => {:static, :integer},
                  "incendiary" => {:static, :integer},
                  "piercing" => {:static, :integer},
                  "special" => {:static, :integer},
                  "total" => {:static, :integer},
                  "tracer" => {:static, :integer}
                }},
             "attacks" =>
               {:object,
                %{
                  "assist" => {:static, :integer},
                  "lost" => {:static, :integer},
                  "stalemate" => {:static, :integer},
                  "stealth" => {:static, :integer},
                  "won" => {:static, :integer}
                }},
             "damage" => {:object, %{"best" => {:static, :integer}, "total" => {:static, :integer}}},
             "defends" =>
               {:object,
                %{
                  "lost" => {:static, :integer},
                  "stalemate" => {:static, :integer},
                  "total" => {:static, :integer},
                  "won" => {:static, :integer}
                }},
             "elo" => {:static, :integer},
             "escapes" => {:object, %{"foes" => {:static, :integer}, "player" => {:static, :integer}}},
             "faction" =>
               {:object,
                %{
                  "raid_hits" => {:static, :integer},
                  "ranked_war_hits" => {:static, :integer},
                  "respect" => {:static, :integer},
                  "retaliations" => {:static, :integer},
                  "territory" =>
                    {:object,
                     %{
                       "wall_clears" => {:static, :integer},
                       "wall_joins" => {:static, :integer},
                       "wall_time" => {:static, :integer}
                     }}
                }},
             "highest_level_beaten" => {:static, :integer},
             "hits" =>
               {:object,
                %{
                  "critical" => {:static, :integer},
                  "miss" => {:static, :integer},
                  "one_hit_kills" => {:static, :integer},
                  "success" => {:static, :integer}
                }},
             "killstreak" => {:object, %{"best" => {:static, :integer}}},
             "networth" =>
               {:object,
                %{
                  "items_looted" => {:static, :integer},
                  "largest_mug" => {:static, :integer},
                  "money_mugged" => {:static, :integer}
                }},
             "unarmored_wins" => {:static, :integer}
           }}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
