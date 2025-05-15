defmodule Torngen.Client.Schema.ForumCategoriesResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :categories
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          categories: [
            %{
              :title => String.t(),
              :threads => integer(),
              :id => Torngen.Client.Schema.ForumId.t(),
              :acronym => String.t()
            }
          ]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      categories: Map.get(data, "categories")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
