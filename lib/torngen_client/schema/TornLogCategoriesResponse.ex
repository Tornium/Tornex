defmodule Torngen.Client.Schema.TornLogCategoriesResponse do
  @moduledoc """
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
      logcategories: Map.get(data, "logcategories")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
