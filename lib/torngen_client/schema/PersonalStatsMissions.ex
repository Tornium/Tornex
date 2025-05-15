defmodule Torngen.Client.Schema.PersonalStatsMissions do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :missions
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          missions: %{
            :missions => integer(),
            :credits => integer(),
            :contracts => %{:total => integer(), :duke => integer()}
          }
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      missions: Map.get(data, "missions")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
