defmodule Torngen.Client.Schema.TornLogTypesResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :logtypes
  ]

  @type t :: %__MODULE__{
          logtypes: [Torngen.Client.Schema.TornLog.t()]
        }
end
