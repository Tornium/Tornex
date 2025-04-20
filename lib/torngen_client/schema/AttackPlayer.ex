defmodule Torngen.Client.Schema.AttackPlayer do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :name,
    :level,
    :id,
    :faction
  ]

  @type t :: %__MODULE__{
          name: String.t(),
          level: integer(),
          id: Torngen.Client.Schema.UserId.t(),
          faction: nil | Torngen.Client.Schema.AttackPlayerFaction.t()
        }
end
