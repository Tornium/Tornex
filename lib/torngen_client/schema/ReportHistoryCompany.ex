defmodule Torngen.Client.Schema.ReportHistoryCompany do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:name, :left, :joined, :id]

  defstruct [
    :name,
    :left,
    :joined,
    :id
  ]

  @type t :: %__MODULE__{
          name: String.t(),
          left: nil | String.t(),
          joined: String.t(),
          id: Torngen.Client.Schema.CompanyId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      left: data |> Map.get("left") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]}),
      joined: data |> Map.get("joined") |> Torngen.Client.Schema.parse({:static, :string}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.CompanyId)
    }
  end

  @impl true
  def parse(_data), do: nil

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:left, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :string]})
  end

  defp validate_key?(:joined, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.CompanyId)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
