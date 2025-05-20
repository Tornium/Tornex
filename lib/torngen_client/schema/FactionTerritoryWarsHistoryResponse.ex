defmodule Torngen.Client.Schema.FactionTerritoryWarsHistoryResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :territorywars
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          territorywars: [Torngen.Client.Schema.FactionTerritoryWarFinished.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      territorywars:
        Map.get(data, "territorywars")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionTerritoryWarFinished})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
