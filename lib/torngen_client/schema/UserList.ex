defmodule Torngen.Client.Schema.UserList do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :status,
    :name,
    :level,
    :last_action,
    :id,
    :faction_id
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          status: Torngen.Client.Schema.UserStatus.t(),
          name: String.t(),
          level: integer(),
          last_action: Torngen.Client.Schema.UserLastAction.t(),
          id: Torngen.Client.Schema.UserId.t(),
          faction_id: nil | Torngen.Client.Schema.FactionId.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      status: Map.get(data, "status"),
      name: Map.get(data, "name"),
      level: Map.get(data, "level"),
      last_action: Map.get(data, "last_action"),
      id: Map.get(data, "id"),
      faction_id: Map.get(data, "faction_id")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
