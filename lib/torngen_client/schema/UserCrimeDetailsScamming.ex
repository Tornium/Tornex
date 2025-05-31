defmodule Torngen.Client.Schema.UserCrimeDetailsScamming do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:zones, :payouts, :most_responses, :emails, :concerns]

  defstruct [
    :zones,
    :payouts,
    :most_responses,
    :emails,
    :concerns
  ]

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

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      zones:
        data
        |> Map.get("zones")
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
        data
        |> Map.get("payouts")
        |> Torngen.Client.Schema.parse(
          {:object, %{"high" => {:static, :integer}, "low" => {:static, :integer}, "medium" => {:static, :integer}}}
        ),
      most_responses: data |> Map.get("most_responses") |> Torngen.Client.Schema.parse({:static, :integer}),
      emails:
        data
        |> Map.get("emails")
        |> Torngen.Client.Schema.parse({:object, %{"phisher" => {:static, :integer}, "scraper" => {:static, :integer}}}),
      concerns:
        data
        |> Map.get("concerns")
        |> Torngen.Client.Schema.parse(
          {:object, %{"attempts" => {:static, :integer}, "resolved" => {:static, :integer}}}
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

  defp validate_key?(:zones, value) do
    Torngen.Client.Schema.validate?(
      value,
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
    )
  end

  defp validate_key?(:payouts, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object, %{"high" => {:static, :integer}, "low" => {:static, :integer}, "medium" => {:static, :integer}}}
    )
  end

  defp validate_key?(:most_responses, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:emails, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object, %{"phisher" => {:static, :integer}, "scraper" => {:static, :integer}}}
    )
  end

  defp validate_key?(:concerns, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object, %{"attempts" => {:static, :integer}, "resolved" => {:static, :integer}}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
