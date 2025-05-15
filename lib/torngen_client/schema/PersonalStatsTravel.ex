defmodule Torngen.Client.Schema.PersonalStatsTravel do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :travel
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          travel: %{
            :united_kingdom => integer(),
            :united_arab_emirates => integer(),
            :total => integer(),
            :time_spent => integer(),
            :switzerland => integer(),
            :south_africa => integer(),
            :mexico => integer(),
            :japan => integer(),
            :items_bought => integer(),
            :hunting => %{:skill => integer()},
            :hawaii => integer(),
            :defends_lost => integer(),
            :china => integer(),
            :cayman_islands => integer(),
            :canada => integer(),
            :attacks_won => integer(),
            :argentina => integer()
          }
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      travel: Map.get(data, "travel")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
