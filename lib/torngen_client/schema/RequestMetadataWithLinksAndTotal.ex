defmodule Torngen.Client.Schema.RequestMetadataWithLinksAndTotal do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :total,
    :links
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          total: integer(),
          links: Torngen.Client.Schema.RequestLinks.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      total: Map.get(data, "total") |> Torngen.Client.Schema.parse({:static, :integer}),
      links: Map.get(data, "links") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.RequestLinks)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
