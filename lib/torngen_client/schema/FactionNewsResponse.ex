defmodule Torngen.Client.Schema.FactionNewsResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :news,
    :_metadata
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          news: [Torngen.Client.Schema.FactionNews.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      news: Map.get(data, "news"),
      _metadata: Map.get(data, "_metadata")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
