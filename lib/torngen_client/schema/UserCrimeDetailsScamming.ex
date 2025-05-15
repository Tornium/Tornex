defmodule Torngen.Client.Schema.UserCrimeDetailsScamming do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :zones,
    :payouts,
    :most_responses,
    :emails,
    :concerns
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          zones: %{
            :temptation => integer(),
            :sensitivity => integer(),
            :red => integer(),
            :neutral => integer(),
            :medium_reward => integer(),
            :low_reward => integer(),
            :high_reward => integer(),
            :hesitation => integer(),
            :concern => integer()
          },
          payouts: %{:medium => integer(), :low => integer(), :high => integer()},
          most_responses: integer(),
          emails: %{:scraper => integer(), :phisher => integer()},
          concerns: %{:resolved => integer(), :attempts => integer()}
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      zones: Map.get(data, "zones"),
      payouts: Map.get(data, "payouts"),
      most_responses: Map.get(data, "most_responses"),
      emails: Map.get(data, "emails"),
      concerns: Map.get(data, "concerns")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
