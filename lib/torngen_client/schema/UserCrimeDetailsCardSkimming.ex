defmodule Torngen.Client.Schema.UserCrimeDetailsCardSkimming do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:skimmers, :card_details]

  defstruct [
    :skimmers,
    :card_details
  ]

  @type t :: %__MODULE__{
          skimmers: %{
            :oldest_recovered => integer(),
            :most_lucrative => integer(),
            :lost => integer(),
            :active => integer()
          },
          card_details: %{
            :sold => integer(),
            :recovered => integer(),
            :recoverable => integer(),
            :lost => integer(),
            :areas => [%{:id => integer(), :amount => integer()}]
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      skimmers:
        Map.get(data, "skimmers")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "active" => {:static, :integer},
             "lost" => {:static, :integer},
             "most_lucrative" => {:static, :integer},
             "oldest_recovered" => {:static, :integer}
           }}
        ),
      card_details:
        Map.get(data, "card_details")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "areas" => {:array, {:object, %{"amount" => {:static, :integer}, "id" => {:static, :integer}}}},
             "lost" => {:static, :integer},
             "recoverable" => {:static, :integer},
             "recovered" => {:static, :integer},
             "sold" => {:static, :integer}
           }}
        )
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

  defp validate_key(:skimmers, value) do
    Torngen.Client.Schema.validate(
      value,
      {:object,
       %{
         "active" => {:static, :integer},
         "lost" => {:static, :integer},
         "most_lucrative" => {:static, :integer},
         "oldest_recovered" => {:static, :integer}
       }}
    )
  end

  defp validate_key(:card_details, value) do
    Torngen.Client.Schema.validate(
      value,
      {:object,
       %{
         "areas" => {:array, {:object, %{"amount" => {:static, :integer}, "id" => {:static, :integer}}}},
         "lost" => {:static, :integer},
         "recoverable" => {:static, :integer},
         "recovered" => {:static, :integer},
         "sold" => {:static, :integer}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
