defmodule Torngen.Client.Schema.TornHof do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :value,
    :username,
    :signed_up,
    :rank_number,
    :rank_name,
    :rank,
    :position,
    :level,
    :last_action,
    :id,
    :faction_id,
    :age_in_days
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          value: term(),
          username: String.t(),
          signed_up: integer(),
          rank_number: integer(),
          rank_name: String.t(),
          rank: String.t(),
          position: integer(),
          level: integer(),
          last_action: integer(),
          id: Torngen.Client.Schema.UserId.t(),
          faction_id: Torngen.Client.Schema.FactionId.t(),
          age_in_days: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      value: Map.get(data, "value") |> Torngen.Client.Schema.parse(:any),
      username: Map.get(data, "username") |> Torngen.Client.Schema.parse({:static, :string}),
      signed_up: Map.get(data, "signed_up") |> Torngen.Client.Schema.parse({:static, :integer}),
      rank_number: Map.get(data, "rank_number") |> Torngen.Client.Schema.parse({:static, :integer}),
      rank_name: Map.get(data, "rank_name") |> Torngen.Client.Schema.parse({:static, :string}),
      rank: Map.get(data, "rank") |> Torngen.Client.Schema.parse({:static, :string}),
      position: Map.get(data, "position") |> Torngen.Client.Schema.parse({:static, :integer}),
      level: Map.get(data, "level") |> Torngen.Client.Schema.parse({:static, :integer}),
      last_action: Map.get(data, "last_action") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId),
      faction_id: Map.get(data, "faction_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionId),
      age_in_days: Map.get(data, "age_in_days") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
