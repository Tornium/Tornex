defmodule Torngen.Client.Schema.FactionRankedWarReportResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :rankedwarreport
  ]

  # TODO: Handle required values in schema parser
  @required []
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

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      rankedwarreport:
        Map.get(data, "rankedwarreport")
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

    # TODO: Handle default values in schema parser and codegen
  end
end
