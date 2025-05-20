defmodule Torngen.Client.Schema.UserHofResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :hof
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          hof: Torngen.Client.Schema.UserHofStats.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      hof: Map.get(data, "hof") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserHofStats)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
