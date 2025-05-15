defmodule Torngen.Client.Schema.TornLogTypesResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :logtypes
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          logtypes: [Torngen.Client.Schema.TornLog.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      logtypes: Map.get(data, "logtypes")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
