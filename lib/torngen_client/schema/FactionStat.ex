defmodule Torngen.Client.Schema.FactionStat do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :value,
    :name
  ]

  @type t :: %__MODULE__{
          value: integer(),
          name: Torngen.Client.Schema.FactionStatEnum.t()
        }
end
