defmodule Torngen.Client.Schema.TornLogCategoriesResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :logcategories
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          logcategories: [Torngen.Client.Schema.TornLogCategory.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      logcategories:
        Map.get(data, "logcategories") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.TornLogCategory})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
