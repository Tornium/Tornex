defmodule Torngen.Client.Schema.UserStatus do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :until,
    :state,
    :details,
    :description
  ]

  @type t :: %__MODULE__{
          until: nil | integer(),
          state: String.t(),
          details: nil | String.t(),
          description: String.t()
        }
end
