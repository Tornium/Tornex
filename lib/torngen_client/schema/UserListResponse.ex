defmodule Torngen.Client.Schema.UserListResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :list,
    :_metadata
  ]

  @type t :: %__MODULE__{
          list: [Torngen.Client.Schema.UserList.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }
end
