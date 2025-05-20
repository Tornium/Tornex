defmodule Torngen.Client.Schema.FactionTerritoryWarReportFaction do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :score,
    :name,
    :members,
    :joins,
    :is_aggressor,
    :id,
    :clears
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          score: integer(),
          name: String.t(),
          members: [Torngen.Client.Schema.FactionTerritoryWarReportMembers.t()],
          joins: integer(),
          is_aggressor: boolean(),
          id: Torngen.Client.Schema.FactionId.t(),
          clears: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      score: Map.get(data, "score") |> Torngen.Client.Schema.parse({:static, :integer}),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      members:
        Map.get(data, "members")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionTerritoryWarReportMembers}),
      joins: Map.get(data, "joins") |> Torngen.Client.Schema.parse({:static, :integer}),
      is_aggressor: Map.get(data, "is_aggressor") |> Torngen.Client.Schema.parse({:static, :boolean}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionId),
      clears: Map.get(data, "clears") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
