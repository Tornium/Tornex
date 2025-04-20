defmodule Torngen.Client.Schema.ForumCategoriesResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :categories
  ]

  @type t :: %__MODULE__{
          categories: [
            %{
              :title => String.t(),
              :threads => integer(),
              :id => Torngen.Client.Schema.ForumId.t(),
              :acronym => String.t()
            }
          ]
        }
end
