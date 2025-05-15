defmodule Torngen.Client.Schema.PersonalStatsAttackingPopular do
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
      attacking: Map.get(data, "attacking")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
