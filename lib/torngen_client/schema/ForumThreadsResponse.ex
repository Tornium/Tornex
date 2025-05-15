defmodule Torngen.Client.Schema.ForumThreadsResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :threads,
    :_metadata
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          threads: [Torngen.Client.Schema.ForumThreadBase.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      threads: Map.get(data, "threads"),
      _metadata: Map.get(data, "_metadata")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
