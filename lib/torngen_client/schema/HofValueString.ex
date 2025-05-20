defmodule Torngen.Client.Schema.HofValueString do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :value,
    :rank
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          value: String.t(),
          rank: nil | integer() | float()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      value: Map.get(data, "value") |> Torngen.Client.Schema.parse({:static, :string}),
      rank: Map.get(data, "rank") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :number]})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
