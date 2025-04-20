defmodule Torngen.Client.Schema.FactionPact do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :until,
    :faction_name,
    :faction_id
  ]

  @type t :: %__MODULE__{
          until: String.t(),
          faction_name: String.t(),
          faction_id: Torngen.Client.Schema.FactionId.t()
        }
end
