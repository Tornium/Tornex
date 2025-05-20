defmodule Torngen.Client.Schema.UserStatus do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:until, :state, :details, :description]

  defstruct [
    :until,
    :state,
    :details,
    :description
  ]

  @type t :: %__MODULE__{
          until: nil | integer(),
          state: String.t(),
          details: nil | String.t(),
          description: String.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      until: Map.get(data, "until") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]}),
      state: Map.get(data, "state") |> Torngen.Client.Schema.parse({:static, :string}),
      details: Map.get(data, "details") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]}),
      description: Map.get(data, "description") |> Torngen.Client.Schema.parse({:static, :string})
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

  defp validate_key(:until, value) do
    Torngen.Client.Schema.validate(value, {:one_of, [static: :null, static: :integer]})
  end

  defp validate_key(:state, value) do
    Torngen.Client.Schema.validate(value, {:static, :string})
  end

  defp validate_key(:details, value) do
    Torngen.Client.Schema.validate(value, {:one_of, [static: :null, static: :string]})
  end

  defp validate_key(:description, value) do
    Torngen.Client.Schema.validate(value, {:static, :string})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
