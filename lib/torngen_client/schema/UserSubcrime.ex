defmodule Torngen.Client.Schema.UserSubcrime do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :total,
    :success,
    :id,
    :fail
  ]

  @type t :: %__MODULE__{
          total: integer(),
          success: integer(),
          id: integer(),
          fail: integer()
        }
end
