defmodule Torngen.Client.Schema.ForumCategoriesResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      categories:
        Map.get(data, "categories")
        |> Torngen.Client.Schema.parse(
          {:array,
           {:object,
            %{
              "acronym" => {:static, :string},
              "id" => Torngen.Client.Schema.ForumId,
              "threads" => {:static, :integer},
              "title" => {:static, :string}
            }}}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
