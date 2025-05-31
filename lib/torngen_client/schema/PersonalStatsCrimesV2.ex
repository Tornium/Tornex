defmodule Torngen.Client.Schema.PersonalStatsCrimesV2 do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:version, :skills, :offenses]

  defstruct [
    :version,
    :skills,
    :offenses
  ]

  @type t :: %__MODULE__{
          version: String.t(),
          skills: %{
            :shoplifting => integer(),
            :search_for_cash => integer(),
            :scamming => integer(),
            :pickpocketing => integer(),
            :hustling => integer(),
            :graffiti => integer(),
            :forgery => integer(),
            :disposal => integer(),
            :cracking => integer(),
            :card_skimming => integer(),
            :burglary => integer(),
            :bootlegging => integer()
          },
          offenses: %{
            :vandalism => integer(),
            :total => integer(),
            :theft => integer(),
            :organized_crimes => integer(),
            :illicit_services => integer(),
            :illegal_production => integer(),
            :fraud => integer(),
            :extortion => integer(),
            :cybercrime => integer(),
            :counterfeiting => integer()
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      version: data |> Map.get("version") |> Torngen.Client.Schema.parse({:static, :string}),
      skills:
        data
        |> Map.get("skills")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "bootlegging" => {:static, :integer},
             "burglary" => {:static, :integer},
             "card_skimming" => {:static, :integer},
             "cracking" => {:static, :integer},
             "disposal" => {:static, :integer},
             "forgery" => {:static, :integer},
             "graffiti" => {:static, :integer},
             "hustling" => {:static, :integer},
             "pickpocketing" => {:static, :integer},
             "scamming" => {:static, :integer},
             "search_for_cash" => {:static, :integer},
             "shoplifting" => {:static, :integer}
           }}
        ),
      offenses:
        data
        |> Map.get("offenses")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "counterfeiting" => {:static, :integer},
             "cybercrime" => {:static, :integer},
             "extortion" => {:static, :integer},
             "fraud" => {:static, :integer},
             "illegal_production" => {:static, :integer},
             "illicit_services" => {:static, :integer},
             "organized_crimes" => {:static, :integer},
             "theft" => {:static, :integer},
             "total" => {:static, :integer},
             "vandalism" => {:static, :integer}
           }}
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

  defp validate_key?(:version, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:skills, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         "bootlegging" => {:static, :integer},
         "burglary" => {:static, :integer},
         "card_skimming" => {:static, :integer},
         "cracking" => {:static, :integer},
         "disposal" => {:static, :integer},
         "forgery" => {:static, :integer},
         "graffiti" => {:static, :integer},
         "hustling" => {:static, :integer},
         "pickpocketing" => {:static, :integer},
         "scamming" => {:static, :integer},
         "search_for_cash" => {:static, :integer},
         "shoplifting" => {:static, :integer}
       }}
    )
  end

  defp validate_key?(:offenses, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         "counterfeiting" => {:static, :integer},
         "cybercrime" => {:static, :integer},
         "extortion" => {:static, :integer},
         "fraud" => {:static, :integer},
         "illegal_production" => {:static, :integer},
         "illicit_services" => {:static, :integer},
         "organized_crimes" => {:static, :integer},
         "theft" => {:static, :integer},
         "total" => {:static, :integer},
         "vandalism" => {:static, :integer}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
