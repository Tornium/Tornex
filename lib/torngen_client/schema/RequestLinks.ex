defmodule Torngen.Client.Schema.RequestLinks do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :prev,
    :next
  ]

  @type t :: %__MODULE__{
          prev: nil | String.t(),
          next: nil | String.t()
        }
end
