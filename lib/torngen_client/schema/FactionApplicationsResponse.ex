defmodule Torngen.Client.Schema.FactionApplicationsResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :applications
  ]

  @type t :: %__MODULE__{
          applications: [Torngen.Client.Schema.FactionApplication.t()]
        }
end
