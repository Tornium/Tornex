defmodule Torngen.Client.Schema.UserCrimeDetailsScamming do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      zones:
        Map.get(data, "zones")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "concern" => {:static, :integer},
             "hesitation" => {:static, :integer},
             "high_reward" => {:static, :integer},
             "low_reward" => {:static, :integer},
             "medium_reward" => {:static, :integer},
             "neutral" => {:static, :integer},
             "red" => {:static, :integer},
             "sensitivity" => {:static, :integer},
             "temptation" => {:static, :integer}
           }}
        ),
      payouts:
        Map.get(data, "payouts")
        |> Torngen.Client.Schema.parse(
          {:object, %{"high" => {:static, :integer}, "low" => {:static, :integer}, "medium" => {:static, :integer}}}
        ),
      most_responses: Map.get(data, "most_responses") |> Torngen.Client.Schema.parse({:static, :integer}),
      emails:
        Map.get(data, "emails")
        |> Torngen.Client.Schema.parse({:object, %{"phisher" => {:static, :integer}, "scraper" => {:static, :integer}}}),
      concerns:
        Map.get(data, "concerns")
        |> Torngen.Client.Schema.parse(
          {:object, %{"attempts" => {:static, :integer}, "resolved" => {:static, :integer}}}
        )
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
