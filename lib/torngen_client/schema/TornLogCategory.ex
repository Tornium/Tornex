defmodule Torngen.Client.Schema.TornLogCategory do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :title,
    :id
  ]

  @type t :: %__MODULE__{
          title: String.t(),
          id: Torngen.Client.Schema.LogCategoryId.t()
        }
end
