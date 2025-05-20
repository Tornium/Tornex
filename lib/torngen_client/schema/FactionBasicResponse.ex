defmodule Torngen.Client.Schema.FactionBasicResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      basic: Map.get(data, "basic") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionBasic)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
