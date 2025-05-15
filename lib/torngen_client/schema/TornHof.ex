defmodule Torngen.Client.Schema.TornHof do
  @moduledoc """
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
      value: Map.get(data, "value"),
      username: Map.get(data, "username"),
      signed_up: Map.get(data, "signed_up"),
      rank_number: Map.get(data, "rank_number"),
      rank_name: Map.get(data, "rank_name"),
      rank: Map.get(data, "rank"),
      position: Map.get(data, "position"),
      level: Map.get(data, "level"),
      last_action: Map.get(data, "last_action"),
      id: Map.get(data, "id"),
      faction_id: Map.get(data, "faction_id"),
      age_in_days: Map.get(data, "age_in_days")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
