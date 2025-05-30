defmodule Torngen.Client.Schema.FactionChainReportAttacker do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:respect, :id, :attacks]

  defstruct [
    :respect,
    :id,
    :attacks
  ]

  @type t :: %__MODULE__{
          respect: Torngen.Client.Schema.FactionChainReportAttackerRespect.t(),
          id: Torngen.Client.Schema.UserId.t(),
          attacks: Torngen.Client.Schema.FactionChainReportAttackerAttacks.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      respect:
        data
        |> Map.get("respect")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionChainReportAttackerRespect),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId),
      attacks:
        data
        |> Map.get("attacks")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionChainReportAttackerAttacks)
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

  defp validate_key?(:respect, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionChainReportAttackerRespect)
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserId)
  end

  defp validate_key?(:attacks, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionChainReportAttackerAttacks)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
