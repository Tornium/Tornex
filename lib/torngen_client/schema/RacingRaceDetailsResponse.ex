defmodule Torngen.Client.Schema.RacingRaceDetailsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:race]

  defstruct [
    :race
  ]

  @type t :: %__MODULE__{
          race: [%{:results => [Torngen.Client.Schema.RacerDetails.t()]} | Torngen.Client.Schema.Race.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      race:
        data
        |> Map.get("race")
        |> Torngen.Client.Schema.parse(
          {:all_of,
           [{:object, %{"results" => {:array, Torngen.Client.Schema.RacerDetails}}}, Torngen.Client.Schema.Race]}
        )
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:race, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:all_of, [{:object, %{"results" => {:array, Torngen.Client.Schema.RacerDetails}}}, Torngen.Client.Schema.Race]}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
