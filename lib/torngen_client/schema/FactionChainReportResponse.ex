defmodule Torngen.Client.Schema.FactionChainReportResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :chainreport
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          chainreport: Torngen.Client.Schema.FactionChainReport.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      chainreport: Map.get(data, "chainreport") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionChainReport)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
