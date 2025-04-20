defmodule Torngen.Client.Schema.FactionHofResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :hof
  ]

  @type t :: %__MODULE__{
          hof: [Torngen.Client.Schema.FactionHofStats.t()]
        }
end
