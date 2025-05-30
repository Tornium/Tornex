defmodule Torngen.Client.Schema.Bounty do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [
    :valid_until,
    :target_name,
    :target_level,
    :target_id,
    :reward,
    :reason,
    :quantity,
    :lister_name,
    :lister_id,
    :is_anonymous
  ]

  defstruct [
    :valid_until,
    :target_name,
    :target_level,
    :target_id,
    :reward,
    :reason,
    :quantity,
    :lister_name,
    :lister_id,
    :is_anonymous
  ]

  @type t :: %__MODULE__{
          valid_until: integer(),
          target_name: String.t(),
          target_level: integer(),
          target_id: Torngen.Client.Schema.UserId.t(),
          reward: integer(),
          reason: nil | String.t(),
          quantity: integer(),
          lister_name: nil | String.t(),
          lister_id: nil | Torngen.Client.Schema.UserId.t(),
          is_anonymous: boolean()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      valid_until: data |> Map.get("valid_until") |> Torngen.Client.Schema.parse({:static, :integer}),
      target_name: data |> Map.get("target_name") |> Torngen.Client.Schema.parse({:static, :string}),
      target_level: data |> Map.get("target_level") |> Torngen.Client.Schema.parse({:static, :integer}),
      target_id: data |> Map.get("target_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId),
      reward: data |> Map.get("reward") |> Torngen.Client.Schema.parse({:static, :integer}),
      reason: data |> Map.get("reason") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]}),
      quantity: data |> Map.get("quantity") |> Torngen.Client.Schema.parse({:static, :integer}),
      lister_name:
        data |> Map.get("lister_name") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]}),
      lister_id:
        data
        |> Map.get("lister_id")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.UserId]}),
      is_anonymous: data |> Map.get("is_anonymous") |> Torngen.Client.Schema.parse({:static, :boolean})
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

  defp validate_key?(:valid_until, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:target_name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:target_level, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:target_id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserId)
  end

  defp validate_key?(:reward, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:reason, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :string]})
  end

  defp validate_key?(:quantity, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:lister_name, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :string]})
  end

  defp validate_key?(:lister_id, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.UserId]})
  end

  defp validate_key?(:is_anonymous, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
