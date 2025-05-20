defmodule Torngen.Client.Schema.PersonalStatsOther do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:other]

  defstruct [
    :other
  ]

  @type t :: %__MODULE__{
          other: %{
            :refills => %{:token => integer(), :nerve => integer(), :energy => integer()},
            :ranked_war_wins => integer(),
            :merits_bought => integer(),
            :donator_days => integer(),
            :awards => integer(),
            :activity => %{:time => integer(), :streak => %{:current => integer(), :best => integer()}}
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      other:
        data
        |> Map.get("other")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "activity" =>
               {:object,
                %{
                  "streak" => {:object, %{"best" => {:static, :integer}, "current" => {:static, :integer}}},
                  "time" => {:static, :integer}
                }},
             "awards" => {:static, :integer},
             "donator_days" => {:static, :integer},
             "merits_bought" => {:static, :integer},
             "ranked_war_wins" => {:static, :integer},
             "refills" =>
               {:object,
                %{"energy" => {:static, :integer}, "nerve" => {:static, :integer}, "token" => {:static, :integer}}}
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

  defp validate_key?(:other, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         "activity" =>
           {:object,
            %{
              "streak" => {:object, %{"best" => {:static, :integer}, "current" => {:static, :integer}}},
              "time" => {:static, :integer}
            }},
         "awards" => {:static, :integer},
         "donator_days" => {:static, :integer},
         "merits_bought" => {:static, :integer},
         "ranked_war_wins" => {:static, :integer},
         "refills" =>
           {:object, %{"energy" => {:static, :integer}, "nerve" => {:static, :integer}, "token" => {:static, :integer}}}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
