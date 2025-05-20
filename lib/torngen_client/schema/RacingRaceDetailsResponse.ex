defmodule Torngen.Client.Schema.RacingRaceDetailsResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:race]

  defstruct [
    :race
  ]

  @type t :: %__MODULE__{
          race: [Torngen.Client.Schema.Race.t() | %{:results => [Torngen.Client.Schema.RacerDetails.t()]}]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      race:
        data
        |> Map.get("race")
        |> Torngen.Client.Schema.parse(
          {:all_of,
           [Torngen.Client.Schema.Race, {:object, %{"results" => {:array, Torngen.Client.Schema.RacerDetails}}}]}
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
      {:all_of, [Torngen.Client.Schema.Race, {:object, %{"results" => {:array, Torngen.Client.Schema.RacerDetails}}}]}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
