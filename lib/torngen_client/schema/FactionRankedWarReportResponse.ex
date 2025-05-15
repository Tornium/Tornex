defmodule Torngen.Client.Schema.FactionRankedWarReportResponse do
  @moduledoc """
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
      rankedwarreport: Map.get(data, "rankedwarreport")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
