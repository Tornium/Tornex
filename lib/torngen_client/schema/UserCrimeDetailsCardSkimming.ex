defmodule Torngen.Client.Schema.UserCrimeDetailsCardSkimming do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

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
end
