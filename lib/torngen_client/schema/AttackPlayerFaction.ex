defmodule Torngen.Client.Schema.AttackPlayerFaction do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :name,
    :id
  ]

  @type t :: %__MODULE__{
          name: String.t(),
          id: Torngen.Client.Schema.FactionId.t()
        }
end
