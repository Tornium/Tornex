defmodule Torngen.Client.Schema.TornItemAmmoResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :itemammo
  ]

  @type t :: %__MODULE__{
          itemammo: [Torngen.Client.Schema.TornItemAmmo.t()]
        }
end
