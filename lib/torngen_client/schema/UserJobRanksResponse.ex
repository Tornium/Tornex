defmodule Torngen.Client.Schema.UserJobRanksResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :jobranks
  ]

  @type t :: %__MODULE__{
          jobranks: Torngen.Client.Schema.UserJobRanks.t()
        }
end
