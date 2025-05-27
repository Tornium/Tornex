defmodule Torngen.Client.Schema.FactionSearch do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:tag_image, :tag, :respect, :name, :members, :leader, :is_recruiting, :is_destroyed, :image, :id, :co_leader]

  defstruct [
    :tag_image,
    :tag,
    :respect,
    :name,
    :members,
    :leader,
    :is_recruiting,
    :is_destroyed,
    :image,
    :id,
    :co_leader
  ]

  @type t :: %__MODULE__{
          tag_image: nil | String.t(),
          tag: nil | String.t(),
          respect: integer(),
          name: String.t(),
          members: integer(),
          leader: Torngen.Client.Schema.FactionSearchLeader.t(),
          is_recruiting: boolean(),
          is_destroyed: boolean(),
          image: nil | String.t(),
          id: Torngen.Client.Schema.FactionId.t(),
          co_leader: nil | Torngen.Client.Schema.FactionSearchLeader.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      tag_image:
        data |> Map.get("tag_image") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]}),
      tag: data |> Map.get("tag") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]}),
      respect: data |> Map.get("respect") |> Torngen.Client.Schema.parse({:static, :integer}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      members: data |> Map.get("members") |> Torngen.Client.Schema.parse({:static, :integer}),
      leader: data |> Map.get("leader") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionSearchLeader),
      is_recruiting: data |> Map.get("is_recruiting") |> Torngen.Client.Schema.parse({:static, :boolean}),
      is_destroyed: data |> Map.get("is_destroyed") |> Torngen.Client.Schema.parse({:static, :boolean}),
      image: data |> Map.get("image") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionId),
      co_leader:
        data
        |> Map.get("co_leader")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.FactionSearchLeader]})
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:tag_image, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :string]})
  end

  defp validate_key?(:tag, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :string]})
  end

  defp validate_key?(:respect, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:members, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:leader, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionSearchLeader)
  end

  defp validate_key?(:is_recruiting, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:is_destroyed, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:image, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :string]})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionId)
  end

  defp validate_key?(:co_leader, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionSearchLeader]})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
