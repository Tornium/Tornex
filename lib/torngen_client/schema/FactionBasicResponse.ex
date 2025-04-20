defmodule Torngen.Client.Schema.FactionBasicResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :basic
  ]

  @type t :: %__MODULE__{
          basic: Torngen.Client.Schema.FactionBasic.t()
        }
end
