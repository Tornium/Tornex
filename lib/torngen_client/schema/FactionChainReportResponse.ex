defmodule Torngen.Client.Schema.FactionChainReportResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:chainreport]

  defstruct [
    :chainreport
  ]

  @type t :: %__MODULE__{
          chainreport: Torngen.Client.Schema.FactionChainReport.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      chainreport: Map.get(data, "chainreport") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionChainReport)
    }

    # TODO: Handle default values in schema parser and codegen
  end

  @impl true
  def validate(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key(key, value) end)
    |> Enum.any?()
  end

  defp validate_key(:chainreport, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.FactionChainReport)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
