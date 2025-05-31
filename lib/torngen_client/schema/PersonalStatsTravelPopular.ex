defmodule Torngen.Client.Schema.PersonalStatsTravelPopular do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:travel]

  defstruct [
    :travel
  ]

  @type t :: %__MODULE__{
          travel: %{:total => integer(), :time_spent => integer()}
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      travel:
        data
        |> Map.get("travel")
        |> Torngen.Client.Schema.parse(
          {:object, %{"time_spent" => {:static, :integer}, "total" => {:static, :integer}}}
        )
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

  defp validate_key?(:travel, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object, %{"time_spent" => {:static, :integer}, "total" => {:static, :integer}}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
