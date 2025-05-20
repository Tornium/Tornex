defmodule Torngen.Client.Schema.FactionTerritoryWarParticipant do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :score,
    :playerIds,
    :name,
    :is_aggressor,
    :id,
    :chain
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          score: integer(),
          playerIds: [Torngen.Client.Schema.UserId.t()],
          name: String.t(),
          is_aggressor: boolean(),
          id: Torngen.Client.Schema.FactionId.t(),
          chain: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      score: Map.get(data, "score") |> Torngen.Client.Schema.parse({:static, :integer}),
      playerIds: Map.get(data, "playerIds") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.UserId}),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      is_aggressor: Map.get(data, "is_aggressor") |> Torngen.Client.Schema.parse({:static, :boolean}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionId),
      chain: Map.get(data, "chain") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
