defmodule Torngen.Client.Schema.FactionWarsResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :wars,
    :pacts
  ]

  @type t :: %__MODULE__{
          wars: Torngen.Client.Schema.FactionWars.t(),
          pacts: [Torngen.Client.Schema.FactionPact.t()]
        }
end
