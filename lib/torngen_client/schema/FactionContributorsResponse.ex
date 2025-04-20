defmodule Torngen.Client.Schema.FactionContributorsResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :contributors
  ]

  @type t :: %__MODULE__{
          contributors: [Torngen.Client.Schema.FactionContributor.t()]
        }
end
