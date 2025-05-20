defmodule Torngen.Client.Schema.ForumSubscribedThreadPostsCount do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:total, :new]

  defstruct [
    :total,
    :new
  ]

  @type t :: %__MODULE__{
          total: integer(),
          new: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      total: Map.get(data, "total") |> Torngen.Client.Schema.parse({:static, :integer}),
      new: Map.get(data, "new") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key(:total, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:new, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
