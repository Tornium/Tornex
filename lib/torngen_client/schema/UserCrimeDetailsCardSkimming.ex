defmodule Torngen.Client.Schema.UserCrimeDetailsCardSkimming do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :skimmers,
    :card_details
  ]

  # TODO: Handle required values in schema parser
  @required []
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

  @spec required() :: list(atom())
  def required(), do: @required

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
end
