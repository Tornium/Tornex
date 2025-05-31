defmodule Torngen.Client.Schema.FactionApplicationsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:applications]

  defstruct [
    :applications
  ]

  @type t :: %__MODULE__{
          applications: [Torngen.Client.Schema.FactionApplication.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      applications:
        data
        |> Map.get("applications")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionApplication})
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

  defp validate_key?(:applications, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.FactionApplication})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
