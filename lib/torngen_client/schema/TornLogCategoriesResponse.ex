defmodule Torngen.Client.Schema.TornLogCategoriesResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :logcategories
  ]

  @type t :: %__MODULE__{
          logcategories: [Torngen.Client.Schema.TornLogCategory.t()]
        }
end
