defmodule Torngen.Client.Schema.FactionPosition do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :name,
    :is_default,
    :abilities
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          name: String.t(),
          is_default: boolean(),
          abilities: [Torngen.Client.Schema.FactionPositionAbilityEnum.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      name: Map.get(data, "name"),
      is_default: Map.get(data, "is_default"),
      abilities: Map.get(data, "abilities")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
