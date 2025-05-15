defmodule Torngen.Client.Schema.FactionOngoingChain do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :timeout,
    :start,
    :modifier,
    :max,
    :id,
    :end,
    :current,
    :cooldown
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          timeout: integer(),
          start: integer(),
          modifier: integer() | float(),
          max: integer(),
          id: Torngen.Client.Schema.ChainId.t(),
          end: integer(),
          current: integer(),
          cooldown: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      timeout: Map.get(data, "timeout"),
      start: Map.get(data, "start"),
      modifier: Map.get(data, "modifier"),
      max: Map.get(data, "max"),
      id: Map.get(data, "id"),
      end: Map.get(data, "end"),
      current: Map.get(data, "current"),
      cooldown: Map.get(data, "cooldown")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
