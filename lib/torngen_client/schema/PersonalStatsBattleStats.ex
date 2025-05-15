defmodule Torngen.Client.Schema.PersonalStatsBattleStats do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :battle_stats
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          battle_stats: %{
            :total => integer(),
            :strength => integer(),
            :speed => integer(),
            :dexterity => integer(),
            :defense => integer()
          }
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      battle_stats: Map.get(data, "battle_stats")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
