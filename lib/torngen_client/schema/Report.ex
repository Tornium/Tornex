defmodule Torngen.Client.Schema.Report do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{values: [Torngen.Client.Schema.ReportReport.t() | Torngen.Client.Schema.ReportBase.t()]}
end
