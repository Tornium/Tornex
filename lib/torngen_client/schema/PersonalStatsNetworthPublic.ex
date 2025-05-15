defmodule Torngen.Client.Schema.PersonalStatsNetworthPublic do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :networth
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          networth: %{:total => integer()}
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      networth: Map.get(data, "networth")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
