defmodule Torngen.Client.Schema.PersonalStatsTravel do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      travel:
        Map.get(data, "travel")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "argentina" => {:static, :integer},
             "attacks_won" => {:static, :integer},
             "canada" => {:static, :integer},
             "cayman_islands" => {:static, :integer},
             "china" => {:static, :integer},
             "defends_lost" => {:static, :integer},
             "hawaii" => {:static, :integer},
             "hunting" => {:object, %{"skill" => {:static, :integer}}},
             "items_bought" => {:static, :integer},
             "japan" => {:static, :integer},
             "mexico" => {:static, :integer},
             "south_africa" => {:static, :integer},
             "switzerland" => {:static, :integer},
             "time_spent" => {:static, :integer},
             "total" => {:static, :integer},
             "united_arab_emirates" => {:static, :integer},
             "united_kingdom" => {:static, :integer}
           }}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
