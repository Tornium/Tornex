defmodule Torngen.Client.Schema.RequestMetadata do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :links
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          links: Torngen.Client.Schema.RequestLinks.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      links: Map.get(data, "links") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.RequestLinks)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
