defmodule Torngen.Client.Schema.PersonalStatsTravel do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:travel]

  defstruct [
    :travel
  ]

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

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      travel:
        data
        |> Map.get("travel")
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

  defp validate_key?(:travel, value) do
    Torngen.Client.Schema.validate?(
      value,
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
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
