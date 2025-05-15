defmodule Torngen.Client.Schema.FactionTerritoryWarsResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :territorywars
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          territorywars:
            [Torngen.Client.Schema.FactionTerritoryWarFinished.t()]
            | [Torngen.Client.Schema.FactionTerritoryWarOngoing.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      territorywars: Map.get(data, "territorywars")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
