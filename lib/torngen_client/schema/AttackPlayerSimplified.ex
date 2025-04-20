defmodule Torngen.Client.Schema.AttackPlayerSimplified do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :id,
    :faction_id
  ]

  @type t :: %__MODULE__{
          id: Torngen.Client.Schema.UserId.t(),
          faction_id: nil | Torngen.Client.Schema.FactionId.t()
        }
end
