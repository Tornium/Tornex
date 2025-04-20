defmodule Torngen.Client.Schema.PersonalStatsMissions do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :missions
  ]

  @type t :: %__MODULE__{
          missions: %{
            :missions => integer(),
            :credits => integer(),
            :contracts => %{:total => integer(), :duke => integer()}
          }
        }
end
