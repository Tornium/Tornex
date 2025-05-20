defmodule Torngen.Client.Schema.ForumCategoriesResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:categories]

  defstruct [
    :categories
  ]

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

  @impl true
  def validate(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key(key, value) end)
    |> Enum.any?()
  end

  defp validate_key(:categories, value) do
    Torngen.Client.Schema.validate(
      value,
      {:array,
       {:object,
        %{
          "acronym" => {:static, :string},
          "id" => Torngen.Client.Schema.ForumId,
          "threads" => {:static, :integer},
          "title" => {:static, :string}
        }}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
