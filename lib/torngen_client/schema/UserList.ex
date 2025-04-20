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

  @type t :: %__MODULE__{
          status: Torngen.Client.Schema.UserStatus.t(),
          name: String.t(),
          level: integer(),
          last_action: Torngen.Client.Schema.UserLastAction.t(),
          id: Torngen.Client.Schema.UserId.t(),
          faction_id: nil | Torngen.Client.Schema.FactionId.t()
        }
end
