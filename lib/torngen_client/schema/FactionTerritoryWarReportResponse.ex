defmodule Torngen.Client.Schema.FactionTerritoryWarReportResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :territorywarreport
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          territorywarreport: [Torngen.Client.Schema.FactionTerritoryWarReport.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      territorywarreport:
        Map.get(data, "territorywarreport")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionTerritoryWarReport})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
