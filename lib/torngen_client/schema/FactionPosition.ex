defmodule Torngen.Client.Schema.FactionPosition do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :name,
    :is_default,
    :abilities
  ]

  @type t :: %__MODULE__{
          name: String.t(),
          is_default: boolean(),
          abilities: [Torngen.Client.Schema.FactionPositionAbilityEnum.t()]
        }
end
