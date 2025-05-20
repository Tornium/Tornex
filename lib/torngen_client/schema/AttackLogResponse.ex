defmodule Torngen.Client.Schema.AttackLogResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:attacklog, :_metadata]

  defstruct [
    :attacklog,
    :_metadata
  ]

  @type t :: %__MODULE__{
          attacklog: %{
            :summary => [Torngen.Client.Schema.AttackLogSummary.t()],
            :log => [Torngen.Client.Schema.AttackLog.t()]
          },
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      attacklog:
        Map.get(data, "attacklog")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "log" => {:array, Torngen.Client.Schema.AttackLog},
             "summary" => {:array, Torngen.Client.Schema.AttackLogSummary}
           }}
        ),
      _metadata:
        Map.get(data, "_metadata") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.RequestMetadataWithLinks)
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

  defp validate_key(:attacklog, value) do
    Torngen.Client.Schema.validate(
      value,
      {:object,
       %{
         "log" => {:array, Torngen.Client.Schema.AttackLog},
         "summary" => {:array, Torngen.Client.Schema.AttackLogSummary}
       }}
    )
  end

  defp validate_key(:_metadata, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.RequestMetadataWithLinks)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
