defmodule Torngen.Client.Schema.PersonalStatsMissions do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:missions]

  defstruct [
    :missions
  ]

  @type t :: %__MODULE__{
          missions: %{
            :missions => integer(),
            :credits => integer(),
            :contracts => %{:total => integer(), :duke => integer()}
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      missions:
        Map.get(data, "missions")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "contracts" => {:object, %{"duke" => {:static, :integer}, "total" => {:static, :integer}}},
             "credits" => {:static, :integer},
             "missions" => {:static, :integer}
           }}
        )
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

  defp validate_key?(:missions, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         "contracts" => {:object, %{"duke" => {:static, :integer}, "total" => {:static, :integer}}},
         "credits" => {:static, :integer},
         "missions" => {:static, :integer}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
