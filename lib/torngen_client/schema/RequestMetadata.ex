defmodule Torngen.Client.Schema.RequestMetadata do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :links
  ]

  @type t :: %__MODULE__{
          links: Torngen.Client.Schema.RequestLinks.t()
        }
end
