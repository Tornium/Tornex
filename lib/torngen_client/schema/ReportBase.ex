defmodule Torngen.Client.Schema.ReportBase do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:type, :timestamp, :target_id, :reporter_id, :faction_id]

  defstruct [
    :type,
    :timestamp,
    :target_id,
    :reporter_id,
    :faction_id
  ]

  @type t :: %__MODULE__{
          type: Torngen.Client.Schema.ReportTypeEnum.t(),
          timestamp: integer(),
          target_id: nil | Torngen.Client.Schema.UserId.t(),
          reporter_id: Torngen.Client.Schema.UserId.t(),
          faction_id: nil | Torngen.Client.Schema.FactionId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      type: data |> Map.get("type") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ReportTypeEnum),
      timestamp: data |> Map.get("timestamp") |> Torngen.Client.Schema.parse({:static, :integer}),
      target_id:
        data
        |> Map.get("target_id")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.UserId]}),
      reporter_id: data |> Map.get("reporter_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId),
      faction_id:
        data
        |> Map.get("faction_id")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.FactionId]})
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:type, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.ReportTypeEnum)
  end

  defp validate_key?(:timestamp, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:target_id, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.UserId]})
  end

  defp validate_key?(:reporter_id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserId)
  end

  defp validate_key?(:faction_id, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionId]})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
