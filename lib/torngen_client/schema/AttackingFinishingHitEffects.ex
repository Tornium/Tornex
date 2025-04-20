defmodule Torngen.Client.Schema.AttackingFinishingHitEffects do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :value,
    :name
  ]

  @type t :: %__MODULE__{
          value: integer(),
          name: Torngen.Client.Schema.AttackFinishingHitEffect.t()
        }
end
