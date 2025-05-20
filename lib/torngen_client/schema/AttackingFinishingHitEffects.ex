defmodule Torngen.Client.Schema.AttackingFinishingHitEffects do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :value,
    :name
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          value: integer(),
          name: Torngen.Client.Schema.AttackFinishingHitEffect.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      value: Map.get(data, "value") |> Torngen.Client.Schema.parse({:static, :integer}),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.AttackFinishingHitEffect)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
