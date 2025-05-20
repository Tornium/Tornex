defmodule Torngen.Client.Schema.UserCalendarResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:calendar]

  defstruct [
    :calendar
  ]

  @type t :: %__MODULE__{
          calendar: Torngen.Client.Schema.UserCalendar.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      calendar: Map.get(data, "calendar") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserCalendar)
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

  defp validate_key?(:calendar, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserCalendar)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
