defmodule Torngen.Client.Schema.FactionRankedWarReportResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:rankedwarreport]

  defstruct [
    :rankedwarreport
  ]

  @type t :: %__MODULE__{
          rankedwarreport: %{
            :winner => Torngen.Client.Schema.FactionId.t(),
            :start => integer(),
            :id => Torngen.Client.Schema.RankedWarId.t(),
            :forfeit => boolean(),
            :factions => [
              %{
                :score => integer(),
                :rewards => %{
                  :respect => integer(),
                  :points => integer(),
                  :items => [%{:quantity => integer(), :name => String.t(), :id => Torngen.Client.Schema.ItemId.t()}]
                },
                :rank => %{:before => String.t(), :after => String.t()},
                :name => String.t(),
                :members => [
                  %{
                    :score => integer() | float(),
                    :name => String.t(),
                    :level => integer(),
                    :id => Torngen.Client.Schema.UserId.t(),
                    :attacks => integer()
                  }
                ],
                :id => Torngen.Client.Schema.FactionId.t(),
                :attacks => integer()
              }
            ],
            :end => integer()
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      rankedwarreport:
        data
        |> Map.get("rankedwarreport")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "end" => {:static, :integer},
             "factions" =>
               {:array,
                {:object,
                 %{
                   "attacks" => {:static, :integer},
                   "id" => Torngen.Client.Schema.FactionId,
                   "members" =>
                     {:array,
                      {:object,
                       %{
                         "attacks" => {:static, :integer},
                         "id" => Torngen.Client.Schema.UserId,
                         "level" => {:static, :integer},
                         "name" => {:static, :string},
                         "score" => {:static, :number}
                       }}},
                   "name" => {:static, :string},
                   "rank" => {:object, %{"after" => {:static, :string}, "before" => {:static, :string}}},
                   "rewards" =>
                     {:object,
                      %{
                        "items" =>
                          {:array,
                           {:object,
                            %{
                              "id" => Torngen.Client.Schema.ItemId,
                              "name" => {:static, :string},
                              "quantity" => {:static, :integer}
                            }}},
                        "points" => {:static, :integer},
                        "respect" => {:static, :integer}
                      }},
                   "score" => {:static, :integer}
                 }}},
             "forfeit" => {:static, :boolean},
             "id" => Torngen.Client.Schema.RankedWarId,
             "start" => {:static, :integer},
             "winner" => Torngen.Client.Schema.FactionId
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

  defp validate_key?(:rankedwarreport, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         "end" => {:static, :integer},
         "factions" =>
           {:array,
            {:object,
             %{
               "attacks" => {:static, :integer},
               "id" => Torngen.Client.Schema.FactionId,
               "members" =>
                 {:array,
                  {:object,
                   %{
                     "attacks" => {:static, :integer},
                     "id" => Torngen.Client.Schema.UserId,
                     "level" => {:static, :integer},
                     "name" => {:static, :string},
                     "score" => {:static, :number}
                   }}},
               "name" => {:static, :string},
               "rank" => {:object, %{"after" => {:static, :string}, "before" => {:static, :string}}},
               "rewards" =>
                 {:object,
                  %{
                    "items" =>
                      {:array,
                       {:object,
                        %{
                          "id" => Torngen.Client.Schema.ItemId,
                          "name" => {:static, :string},
                          "quantity" => {:static, :integer}
                        }}},
                    "points" => {:static, :integer},
                    "respect" => {:static, :integer}
                  }},
               "score" => {:static, :integer}
             }}},
         "forfeit" => {:static, :boolean},
         "id" => Torngen.Client.Schema.RankedWarId,
         "start" => {:static, :integer},
         "winner" => Torngen.Client.Schema.FactionId
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
