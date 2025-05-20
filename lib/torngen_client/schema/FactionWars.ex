defmodule Torngen.Client.Schema.FactionWars do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      territory:
        Map.get(data, "territory") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionTerritoryWar}),
      ranked:
        Map.get(data, "ranked")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.FactionRankedWar]}),
      raids: Map.get(data, "raids") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionRaidWar})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
