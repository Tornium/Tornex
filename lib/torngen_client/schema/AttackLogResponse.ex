defmodule Torngen.Client.Schema.AttackLogResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :attacklog,
    :_metadata
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          attacklog: %{
            :summary => [Torngen.Client.Schema.AttackLogSummary.t()],
            :log => [Torngen.Client.Schema.AttackLog.t()]
          },
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      attacklog:
        Map.get(data, "attacklog")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             "log" => {:array, Torngen.Client.Schema.AttackLog},
             "summary" => {:array, Torngen.Client.Schema.AttackLogSummary}
           }}
        ),
      _metadata:
        Map.get(data, "_metadata") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.RequestMetadataWithLinks)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
