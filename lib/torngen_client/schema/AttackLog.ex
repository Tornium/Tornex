defmodule Torngen.Client.Schema.AttackLog do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:timestamp, :text, :icon, :defender, :attacker_item, :attacker, :action]

  defstruct [
    :timestamp,
    :text,
    :icon,
    :defender,
    :attacker_item,
    :attacker,
    :action
  ]

  @type t :: %__MODULE__{
          timestamp: integer(),
          text: String.t(),
          icon: String.t(),
          defender: nil | %{:name => String.t(), :id => Torngen.Client.Schema.UserId.t()},
          attacker_item: %{:name => String.t(), :id => Torngen.Client.Schema.ItemId.t()},
          attacker:
            nil
            | %{
                :name => String.t(),
                :item => nil | %{:name => String.t(), :id => Torngen.Client.Schema.ItemId.t()},
                :id => Torngen.Client.Schema.UserId.t()
              },
          action: Torngen.Client.Schema.AttackActionEnum.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      timestamp: data |> Map.get("timestamp") |> Torngen.Client.Schema.parse({:static, :integer}),
      text: data |> Map.get("text") |> Torngen.Client.Schema.parse({:static, :string}),
      icon: data |> Map.get("icon") |> Torngen.Client.Schema.parse({:static, :string}),
      defender:
        data
        |> Map.get("defender")
        |> Torngen.Client.Schema.parse(
          {:one_of, [static: :null, object: %{"id" => Torngen.Client.Schema.UserId, "name" => {:static, :string}}]}
        ),
      attacker_item:
        data
        |> Map.get("attacker_item")
        |> Torngen.Client.Schema.parse({:object, %{"id" => Torngen.Client.Schema.ItemId, "name" => {:static, :string}}}),
      attacker:
        data
        |> Map.get("attacker")
        |> Torngen.Client.Schema.parse(
          {:one_of,
           [
             static: :null,
             object: %{
               "id" => Torngen.Client.Schema.UserId,
               "item" =>
                 {:one_of,
                  [static: :null, object: %{"id" => Torngen.Client.Schema.ItemId, "name" => {:static, :string}}]},
               "name" => {:static, :string}
             }
           ]}
        ),
      action: data |> Map.get("action") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.AttackActionEnum)
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:timestamp, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:text, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:icon, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:defender, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [static: :null, object: %{"id" => Torngen.Client.Schema.UserId, "name" => {:static, :string}}]}
    )
  end

  defp validate_key?(:attacker_item, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object, %{"id" => Torngen.Client.Schema.ItemId, "name" => {:static, :string}}}
    )
  end

  defp validate_key?(:attacker, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of,
       [
         static: :null,
         object: %{
           "id" => Torngen.Client.Schema.UserId,
           "item" =>
             {:one_of, [static: :null, object: %{"id" => Torngen.Client.Schema.ItemId, "name" => {:static, :string}}]},
           "name" => {:static, :string}
         }
       ]}
    )
  end

  defp validate_key?(:action, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.AttackActionEnum)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
