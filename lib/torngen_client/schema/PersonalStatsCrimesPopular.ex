defmodule Torngen.Client.Schema.PersonalStatsCrimesPopular do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :crimes
  ]

  @type t :: %__MODULE__{
          crimes: %{:version => String.t(), :total => integer()}
        }
end
