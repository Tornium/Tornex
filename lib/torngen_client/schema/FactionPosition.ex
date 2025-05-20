defmodule Torngen.Client.Schema.FactionPosition do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      is_default: Map.get(data, "is_default") |> Torngen.Client.Schema.parse({:static, :boolean}),
      abilities:
        Map.get(data, "abilities")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionPositionAbilityEnum})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
