defmodule Torngen.Client.Schema.FactionRankedWarDetails do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:winner, :target, :start, :id, :factions, :end]

  defstruct [
    :winner,
    :target,
    :start,
    :id,
    :factions,
    :end
  ]

  @type t :: %__MODULE__{
          winner: nil | Torngen.Client.Schema.FactionId.t(),
          target: integer(),
          start: integer(),
          id: Torngen.Client.Schema.RankedWarId.t(),
          factions: [
            %{:score => integer(), :name => String.t(), :id => Torngen.Client.Schema.FactionId.t(), :chain => integer()}
          ],
          end: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      winner:
        data
        |> Map.get("winner")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.FactionId]}),
      target: data |> Map.get("target") |> Torngen.Client.Schema.parse({:static, :integer}),
      start: data |> Map.get("start") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.RankedWarId),
      factions:
        data
        |> Map.get("factions")
        |> Torngen.Client.Schema.parse(
          {:array,
           {:object,
            %{
              "chain" => {:static, :integer},
              "id" => Torngen.Client.Schema.FactionId,
              "name" => {:static, :string},
              "score" => {:static, :integer}
            }}}
        ),
      end: data |> Map.get("end") |> Torngen.Client.Schema.parse({:static, :integer})
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:winner, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionId]})
  end

  defp validate_key?(:target, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:start, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.RankedWarId)
  end

  defp validate_key?(:factions, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array,
       {:object,
        %{
          "chain" => {:static, :integer},
          "id" => Torngen.Client.Schema.FactionId,
          "name" => {:static, :string},
          "score" => {:static, :integer}
        }}}
    )
  end

  defp validate_key?(:end, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
