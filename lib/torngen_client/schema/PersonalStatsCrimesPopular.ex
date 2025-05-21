defmodule Torngen.Client.Schema.PersonalStatsCrimesPopular do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:crimes]

  defstruct [
    :crimes
  ]

  @type t :: %__MODULE__{
          crimes: %{:version => String.t(), :total => integer()}
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      crimes:
        data
        |> Map.get("crimes")
        |> Torngen.Client.Schema.parse({:object, %{"total" => {:static, :integer}, "version" => {:static, :string}}})
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:crimes, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object, %{"total" => {:static, :integer}, "version" => {:static, :string}}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
