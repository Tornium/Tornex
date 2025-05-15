defmodule Torngen.Client.Schema.FactionWars do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :territory,
    :ranked,
    :raids
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          territory: [Torngen.Client.Schema.FactionTerritoryWar.t()],
          ranked: nil | Torngen.Client.Schema.FactionRankedWar.t(),
          raids: [Torngen.Client.Schema.FactionRaidWar.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      territory: Map.get(data, "territory"),
      ranked: Map.get(data, "ranked"),
      raids: Map.get(data, "raids")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
