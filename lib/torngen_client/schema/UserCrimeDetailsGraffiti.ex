defmodule Torngen.Client.Schema.UserCrimeDetailsGraffiti do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:most_graffiti_simultaneously, :most_graffiti_in_one_area, :graffiti_removed, :cost_to_city, :cans_used]

  defstruct [
    :most_graffiti_simultaneously,
    :most_graffiti_in_one_area,
    :graffiti_removed,
    :cost_to_city,
    :cans_used
  ]

  @type t :: %__MODULE__{
          most_graffiti_simultaneously: integer(),
          most_graffiti_in_one_area: integer(),
          graffiti_removed: integer(),
          cost_to_city: integer(),
          cans_used: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      most_graffiti_simultaneously:
        data |> Map.get("most_graffiti_simultaneously") |> Torngen.Client.Schema.parse({:static, :integer}),
      most_graffiti_in_one_area:
        data |> Map.get("most_graffiti_in_one_area") |> Torngen.Client.Schema.parse({:static, :integer}),
      graffiti_removed: data |> Map.get("graffiti_removed") |> Torngen.Client.Schema.parse({:static, :integer}),
      cost_to_city: data |> Map.get("cost_to_city") |> Torngen.Client.Schema.parse({:static, :integer}),
      cans_used: data |> Map.get("cans_used") |> Torngen.Client.Schema.parse({:static, :integer})
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:most_graffiti_simultaneously, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:most_graffiti_in_one_area, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:graffiti_removed, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:cost_to_city, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:cans_used, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
