defmodule Torngen.Client.Schema.TornItemAmmoResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :itemammo
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          itemammo: [Torngen.Client.Schema.TornItemAmmo.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      itemammo: Map.get(data, "itemammo")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
