defmodule Torngen.Client.Schema.FactionBasicResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :basic
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          basic: Torngen.Client.Schema.FactionBasic.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      basic: Map.get(data, "basic")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
