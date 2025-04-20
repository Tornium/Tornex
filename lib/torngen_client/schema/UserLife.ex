defmodule Torngen.Client.Schema.UserLife do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :maximum,
    :current
  ]

  @type t :: %__MODULE__{
          maximum: integer(),
          current: integer()
        }
end
