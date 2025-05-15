defmodule Torngen.Client.Schema.PersonalStatsOtherPopular do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :other
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          other: %{
            :refills => %{:nerve => integer(), :energy => integer()},
            :ranked_war_wins => integer(),
            :merits_bought => integer(),
            :donator_days => integer(),
            :awards => integer(),
            :activity => %{:time => integer(), :streak => %{:current => integer(), :best => integer()}}
          }
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      other: Map.get(data, "other")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
