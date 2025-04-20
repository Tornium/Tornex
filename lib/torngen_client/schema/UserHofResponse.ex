defmodule Torngen.Client.Schema.UserHofResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :hof
  ]

  @type t :: %__MODULE__{
          hof: [Torngen.Client.Schema.UserHofStats.t()]
        }
end
