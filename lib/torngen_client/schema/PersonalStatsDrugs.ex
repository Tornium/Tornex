defmodule Torngen.Client.Schema.PersonalStatsDrugs do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:drugs]

  defstruct [
    :drugs
  ]

  @type t :: %__MODULE__{
          drugs: %{
            :xanax => integer(),
            :vicodin => integer(),
            :total => integer(),
            :speed => integer(),
            :shrooms => integer(),
            :rehabilitations => %{:fees => integer(), :amount => integer()},
            :pcp => integer(),
            :overdoses => integer(),
            :opium => integer(),
            :lsd => integer(),
            :ketamine => integer(),
            :ecstasy => integer(),
            :cannabis => integer()
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      drugs:
        Map.get(data, "drugs")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "cannabis" => {:static, :integer},
             "ecstasy" => {:static, :integer},
             "ketamine" => {:static, :integer},
             "lsd" => {:static, :integer},
             "opium" => {:static, :integer},
             "overdoses" => {:static, :integer},
             "pcp" => {:static, :integer},
             "rehabilitations" => {:object, %{"amount" => {:static, :integer}, "fees" => {:static, :integer}}},
             "shrooms" => {:static, :integer},
             "speed" => {:static, :integer},
             "total" => {:static, :integer},
             "vicodin" => {:static, :integer},
             "xanax" => {:static, :integer}
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

  defp validate_key?(:drugs, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         "cannabis" => {:static, :integer},
         "ecstasy" => {:static, :integer},
         "ketamine" => {:static, :integer},
         "lsd" => {:static, :integer},
         "opium" => {:static, :integer},
         "overdoses" => {:static, :integer},
         "pcp" => {:static, :integer},
         "rehabilitations" => {:object, %{"amount" => {:static, :integer}, "fees" => {:static, :integer}}},
         "shrooms" => {:static, :integer},
         "speed" => {:static, :integer},
         "total" => {:static, :integer},
         "vicodin" => {:static, :integer},
         "xanax" => {:static, :integer}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
