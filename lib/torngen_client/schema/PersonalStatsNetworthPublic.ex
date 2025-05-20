defmodule Torngen.Client.Schema.PersonalStatsNetworthPublic do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:networth]

  defstruct [
    :networth
  ]

  @type t :: %__MODULE__{
          networth: %{:total => integer()}
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      networth: data |> Map.get("networth") |> Torngen.Client.Schema.parse({:object, %{"total" => {:static, :integer}}})
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:networth, value) do
    Torngen.Client.Schema.validate?(value, {:object, %{"total" => {:static, :integer}}})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
