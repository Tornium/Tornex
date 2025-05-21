defmodule Torngen.Client.Schema.FactionCrimeSlot do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:user, :position, :item_requirement, :checkpoint_pass_rate]

  defstruct [
    :user,
    :position,
    :item_requirement,
    :checkpoint_pass_rate
  ]

  @type t :: %__MODULE__{
          user: nil | Torngen.Client.Schema.FactionCrimeUser.t(),
          position: String.t(),
          item_requirement:
            nil | %{:is_reusable => boolean(), :is_available => boolean(), :id => Torngen.Client.Schema.ItemId.t()},
          checkpoint_pass_rate: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      user:
        data
        |> Map.get("user")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.FactionCrimeUser]}),
      position: data |> Map.get("position") |> Torngen.Client.Schema.parse({:static, :string}),
      item_requirement:
        data
        |> Map.get("item_requirement")
        |> Torngen.Client.Schema.parse(
          {:one_of,
           [
             static: :null,
             object: %{
               "id" => Torngen.Client.Schema.ItemId,
               "is_available" => {:static, :boolean},
               "is_reusable" => {:static, :boolean}
             }
           ]}
        ),
      checkpoint_pass_rate: data |> Map.get("checkpoint_pass_rate") |> Torngen.Client.Schema.parse({:static, :integer})
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:user, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionCrimeUser]})
  end

  defp validate_key?(:position, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:item_requirement, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of,
       [
         static: :null,
         object: %{
           "id" => Torngen.Client.Schema.ItemId,
           "is_available" => {:static, :boolean},
           "is_reusable" => {:static, :boolean}
         }
       ]}
    )
  end

  defp validate_key?(:checkpoint_pass_rate, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
