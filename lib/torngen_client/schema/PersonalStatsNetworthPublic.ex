defmodule Torngen.Client.Schema.PersonalStatsNetworthPublic do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :networth
  ]

  @type t :: %__MODULE__{
          networth: %{:total => integer()}
        }
end
