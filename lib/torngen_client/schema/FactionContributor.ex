defmodule Torngen.Client.Schema.FactionContributor do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :value,
    :username,
    :in_faction,
    :id
  ]

  @type t :: %__MODULE__{
          value: integer(),
          username: String.t(),
          in_faction: boolean(),
          id: Torngen.Client.Schema.UserId.t()
        }
end
