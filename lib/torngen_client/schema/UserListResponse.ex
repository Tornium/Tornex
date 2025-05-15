defmodule Torngen.Client.Schema.UserListResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :list,
    :_metadata
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          list: [Torngen.Client.Schema.UserList.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      list: Map.get(data, "list"),
      _metadata: Map.get(data, "_metadata")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
