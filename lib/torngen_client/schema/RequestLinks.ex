defmodule Torngen.Client.Schema.RequestLinks do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :prev,
    :next
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          prev: nil | String.t(),
          next: nil | String.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      prev: Map.get(data, "prev") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]}),
      next: Map.get(data, "next") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
