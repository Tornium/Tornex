defmodule Torngen.Client.Schema.UserCrimeDetailsShoplifting do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :average_notoriety
  ]

  @type t :: %__MODULE__{
          average_notoriety: integer()
        }
end
