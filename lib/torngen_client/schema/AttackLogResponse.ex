defmodule Torngen.Client.Schema.AttackLogResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :attacklog,
    :_metadata
  ]

  @type t :: %__MODULE__{
          attacklog: %{
            :summary => [Torngen.Client.Schema.AttackLogSummary.t()],
            :log => [Torngen.Client.Schema.AttackLog.t()]
          },
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }
end
