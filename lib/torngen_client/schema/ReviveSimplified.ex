defmodule Torngen.Client.Schema.ReviveSimplified do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:timestamp, :target, :success_chance, :reviver, :result, :id]

  defstruct [
    :timestamp,
    :target,
    :success_chance,
    :reviver,
    :result,
    :id
  ]

  @type t :: %__MODULE__{
          timestamp: integer(),
          target: %{
            :online_status => String.t(),
            :last_action => integer(),
            :id => Torngen.Client.Schema.UserId.t(),
            :hospital_reason => String.t(),
            :faction_id => nil | Torngen.Client.Schema.FactionId.t(),
            :early_discharge => boolean()
          },
          success_chance: integer() | float(),
          reviver: %{:id => Torngen.Client.Schema.UserId.t(), :faction_id => nil | Torngen.Client.Schema.FactionId.t()},
          result: String.t(),
          id: Torngen.Client.Schema.ReviveId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      timestamp: Map.get(data, "timestamp") |> Torngen.Client.Schema.parse({:static, :integer}),
      target:
        Map.get(data, "target")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "early_discharge" => {:static, :boolean},
             "faction_id" => {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionId]},
             "hospital_reason" => {:static, :string},
             "id" => Torngen.Client.Schema.UserId,
             "last_action" => {:static, :integer},
             "online_status" => {:static, :string}
           }}
        ),
      success_chance: Map.get(data, "success_chance") |> Torngen.Client.Schema.parse({:static, :number}),
      reviver:
        Map.get(data, "reviver")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "faction_id" => {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionId]},
             "id" => Torngen.Client.Schema.UserId
           }}
        ),
      result: Map.get(data, "result") |> Torngen.Client.Schema.parse({:static, :string}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ReviveId)
    }

    # TODO: Handle default values in schema parser and codegen
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

  defp validate_key?(:target, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         "early_discharge" => {:static, :boolean},
         "faction_id" => {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionId]},
         "hospital_reason" => {:static, :string},
         "id" => Torngen.Client.Schema.UserId,
         "last_action" => {:static, :integer},
         "online_status" => {:static, :string}
       }}
    )
  end

  defp validate_key?(:success_chance, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  defp validate_key?(:reviver, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         "faction_id" => {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionId]},
         "id" => Torngen.Client.Schema.UserId
       }}
    )
  end

  defp validate_key?(:result, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.ReviveId)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
