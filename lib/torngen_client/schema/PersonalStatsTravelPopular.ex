defmodule Torngen.Client.Schema.PersonalStatsTravelPopular do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :travel
  ]

  @type t :: %__MODULE__{
          travel: %{:total => integer(), :time_spent => integer()}
        }
end
