defmodule Torngen.Client.Schema.PersonalStatsRacing do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:racing]

  defstruct [
    :racing
  ]

  @type t :: %__MODULE__{
          racing: %{:skill => integer(), :races => %{:won => integer(), :entered => integer()}, :points => integer()}
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      racing:
        data
        |> Map.get("racing")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "points" => {:static, :integer},
             "races" => {:object, %{"entered" => {:static, :integer}, "won" => {:static, :integer}}},
             "skill" => {:static, :integer}
           }}
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

  defp validate_key?(:racing, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         "points" => {:static, :integer},
         "races" => {:object, %{"entered" => {:static, :integer}, "won" => {:static, :integer}}},
         "skill" => {:static, :integer}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
