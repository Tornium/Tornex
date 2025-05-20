defmodule Torngen.Client.Schema.FactionBasic do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [
    :tag_image,
    :tag,
    :respect,
    :rank,
    :name,
    :members,
    :leader_id,
    :is_enlisted,
    :id,
    :days_old,
    :co_leader_id,
    :"co-leader_id",
    :capacity,
    :best_chain
  ]

  defstruct [
    :tag_image,
    :tag,
    :respect,
    :rank,
    :name,
    :members,
    :leader_id,
    :is_enlisted,
    :id,
    :days_old,
    :co_leader_id,
    :"co-leader_id",
    :capacity,
    :best_chain
  ]

  @type t :: %__MODULE__{
          tag_image: String.t(),
          tag: String.t(),
          respect: integer(),
          rank: Torngen.Client.Schema.FactionRank.t(),
          name: String.t(),
          members: integer(),
          leader_id: Torngen.Client.Schema.UserId.t(),
          is_enlisted: nil | boolean(),
          id: Torngen.Client.Schema.FactionId.t(),
          days_old: integer(),
          co_leader_id: Torngen.Client.Schema.UserId.t(),
          "co-leader_id": Torngen.Client.Schema.UserId.t(),
          capacity: integer(),
          best_chain: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      tag_image: Map.get(data, "tag_image") |> Torngen.Client.Schema.parse({:static, :string}),
      tag: Map.get(data, "tag") |> Torngen.Client.Schema.parse({:static, :string}),
      respect: Map.get(data, "respect") |> Torngen.Client.Schema.parse({:static, :integer}),
      rank: Map.get(data, "rank") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionRank),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      members: Map.get(data, "members") |> Torngen.Client.Schema.parse({:static, :integer}),
      leader_id: Map.get(data, "leader_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId),
      is_enlisted:
        Map.get(data, "is_enlisted") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :boolean]}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionId),
      days_old: Map.get(data, "days_old") |> Torngen.Client.Schema.parse({:static, :integer}),
      co_leader_id: Map.get(data, "co_leader_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId),
      capacity: Map.get(data, "capacity") |> Torngen.Client.Schema.parse({:static, :integer}),
      best_chain: Map.get(data, "best_chain") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key(:tag_image, value) do
    Torngen.Client.Schema.validate(value, {:static, :string})
  end

  defp validate_key(:tag, value) do
    Torngen.Client.Schema.validate(value, {:static, :string})
  end

  defp validate_key(:respect, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:rank, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.FactionRank)
  end

  defp validate_key(:name, value) do
    Torngen.Client.Schema.validate(value, {:static, :string})
  end

  defp validate_key(:members, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:leader_id, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.UserId)
  end

  defp validate_key(:is_enlisted, value) do
    Torngen.Client.Schema.validate(value, {:one_of, [static: :null, static: :boolean]})
  end

  defp validate_key(:id, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.FactionId)
  end

  defp validate_key(:days_old, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:co_leader_id, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.UserId)
  end

  defp validate_key(:"co-leader_id", value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.UserId)
  end

  defp validate_key(:capacity, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:best_chain, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
