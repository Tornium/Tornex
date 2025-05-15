defmodule Torngen.Client.Schema.PersonalStatsRacing do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :racing
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          racing: %{:skill => integer(), :races => %{:won => integer(), :entered => integer()}, :points => integer()}
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      racing: Map.get(data, "racing")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
