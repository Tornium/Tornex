defmodule Torngen.Client.Schema.TornLog do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :title,
    :id
  ]

  @type t :: %__MODULE__{
          title: String.t(),
          id: Torngen.Client.Schema.LogId.t()
        }
end
