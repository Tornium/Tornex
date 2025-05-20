defmodule Torngen.Client.Schema.UserLife do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :maximum,
    :current
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          maximum: integer(),
          current: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      maximum: Map.get(data, "maximum") |> Torngen.Client.Schema.parse({:static, :integer}),
      current: Map.get(data, "current") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
