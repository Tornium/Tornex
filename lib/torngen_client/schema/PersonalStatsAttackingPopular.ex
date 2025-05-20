defmodule Torngen.Client.Schema.PersonalStatsAttackingPopular do
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

    # TODO: Handle default values in schema parser and codegen
  end
end
