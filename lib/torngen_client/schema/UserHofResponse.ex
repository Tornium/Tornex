defmodule Torngen.Client.Schema.UserHofResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :hof
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          hof: Torngen.Client.Schema.UserHofStats.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      hof: Map.get(data, "hof")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
