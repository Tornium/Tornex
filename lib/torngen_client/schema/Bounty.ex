defmodule Torngen.Client.Schema.Bounty do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

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
      valid_until: Map.get(data, "valid_until") |> Torngen.Client.Schema.parse({:static, :integer}),
      target_name: Map.get(data, "target_name") |> Torngen.Client.Schema.parse({:static, :string}),
      target_level: Map.get(data, "target_level") |> Torngen.Client.Schema.parse({:static, :integer}),
      target_id: Map.get(data, "target_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId),
      reward: Map.get(data, "reward") |> Torngen.Client.Schema.parse({:static, :integer}),
      reason: Map.get(data, "reason") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]}),
      quantity: Map.get(data, "quantity") |> Torngen.Client.Schema.parse({:static, :integer}),
      lister_name:
        Map.get(data, "lister_name") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]}),
      lister_id:
        Map.get(data, "lister_id")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.UserId]}),
      is_anonymous: Map.get(data, "is_anonymous") |> Torngen.Client.Schema.parse({:static, :boolean})
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

  defp validate_key(:valid_until, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:target_name, value) do
    Torngen.Client.Schema.validate(value, {:static, :string})
  end

  defp validate_key(:target_level, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:target_id, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.UserId)
  end

  defp validate_key(:reward, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:reason, value) do
    Torngen.Client.Schema.validate(value, {:one_of, [static: :null, static: :string]})
  end

  defp validate_key(:quantity, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:lister_name, value) do
    Torngen.Client.Schema.validate(value, {:one_of, [static: :null, static: :string]})
  end

  defp validate_key(:lister_id, value) do
    Torngen.Client.Schema.validate(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.UserId]})
  end

  defp validate_key(:is_anonymous, value) do
    Torngen.Client.Schema.validate(value, {:static, :boolean})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
