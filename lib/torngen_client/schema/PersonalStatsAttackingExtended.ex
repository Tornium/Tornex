defmodule Torngen.Client.Schema.PersonalStatsAttackingExtended do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:attacking]

  defstruct [
    :attacking
  ]

  @type t :: %__MODULE__{
          attacking: %{
            :unarmored_wins => integer(),
            :networth => %{:money_mugged => integer(), :largest_mug => integer(), :items_looted => integer()},
            :killstreak => %{:current => integer(), :best => integer()},
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

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      attacking:
        data
        |> Map.get("attacking")
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
             "killstreak" => {:object, %{"best" => {:static, :integer}, "current" => {:static, :integer}}},
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
  end

  @impl true
  def parse(_data), do: nil

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:attacking, value) do
    Torngen.Client.Schema.validate?(
      value,
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
         "killstreak" => {:object, %{"best" => {:static, :integer}, "current" => {:static, :integer}}},
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
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
