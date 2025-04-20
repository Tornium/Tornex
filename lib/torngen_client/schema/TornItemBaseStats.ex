defmodule Torngen.Client.Schema.TornItemBaseStats do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :damage,
    :armor,
    :accuracy
  ]

  @type t :: %__MODULE__{
          damage: integer(),
          armor: integer(),
          accuracy: integer()
        }
end
