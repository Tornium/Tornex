defmodule Torngen.Client.Schema.FactionTerritoryWarReportMembers do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :username,
    :score,
    :level,
    :joins,
    :id,
    :clears
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          username: String.t(),
          score: integer(),
          level: integer(),
          joins: integer(),
          id: Torngen.Client.Schema.UserId.t(),
          clears: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      username: Map.get(data, "username") |> Torngen.Client.Schema.parse({:static, :string}),
      score: Map.get(data, "score") |> Torngen.Client.Schema.parse({:static, :integer}),
      level: Map.get(data, "level") |> Torngen.Client.Schema.parse({:static, :integer}),
      joins: Map.get(data, "joins") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId),
      clears: Map.get(data, "clears") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
