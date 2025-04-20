defmodule Torngen.Client.Schema.FactionChainReportResponse do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :chainreport
  ]

  @type t :: %__MODULE__{
          chainreport: Torngen.Client.Schema.FactionChainReport.t()
        }
end
