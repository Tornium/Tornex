defmodule Torngen.Client.Schema.PersonalStatsAttackingPopular do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:attacking]

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
                  "won" => {:static, :integer}
                }},
             "damage" => {:object, %{"best" => {:static, :integer}, "total" => {:static, :integer}}},
             "defends" =>
               {:object,
                %{"lost" => {:static, :integer}, "stalemate" => {:static, :integer}, "won" => {:static, :integer}}},
             "elo" => {:static, :integer},
             "escapes" => {:object, %{"foes" => {:static, :integer}, "player" => {:static, :integer}}},
             "faction" => {:object, %{"ranked_war_hits" => {:static, :integer}, "respect" => {:static, :integer}}},
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
                }}
           }}
        )
    }
  end

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
              "won" => {:static, :integer}
            }},
         "damage" => {:object, %{"best" => {:static, :integer}, "total" => {:static, :integer}}},
         "defends" =>
           {:object, %{"lost" => {:static, :integer}, "stalemate" => {:static, :integer}, "won" => {:static, :integer}}},
         "elo" => {:static, :integer},
         "escapes" => {:object, %{"foes" => {:static, :integer}, "player" => {:static, :integer}}},
         "faction" => {:object, %{"ranked_war_hits" => {:static, :integer}, "respect" => {:static, :integer}}},
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
            }}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
