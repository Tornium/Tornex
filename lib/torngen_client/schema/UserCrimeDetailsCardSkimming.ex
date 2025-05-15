defmodule Torngen.Client.Schema.UserCrimeDetailsCardSkimming do
  @moduledoc """
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
      skimmers: Map.get(data, "skimmers"),
      card_details: Map.get(data, "card_details")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
