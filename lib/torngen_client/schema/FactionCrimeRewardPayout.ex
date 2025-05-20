defmodule Torngen.Client.Schema.FactionCrimeRewardPayout do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:type, :percentage, :paid_by, :paid_at]

  defstruct [
    :type,
    :percentage,
    :paid_by,
    :paid_at
  ]

  @type t :: %__MODULE__{
          type: Torngen.Client.Schema.FactionOrganizedCrimePayoutType.t(),
          percentage: integer(),
          paid_by: Torngen.Client.Schema.UserId.t(),
          paid_at: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      type: Map.get(data, "type") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionOrganizedCrimePayoutType),
      percentage: Map.get(data, "percentage") |> Torngen.Client.Schema.parse({:static, :integer}),
      paid_by: Map.get(data, "paid_by") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId),
      paid_at: Map.get(data, "paid_at") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:type, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionOrganizedCrimePayoutType)
  end

  defp validate_key?(:percentage, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:paid_by, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserId)
  end

  defp validate_key?(:paid_at, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
