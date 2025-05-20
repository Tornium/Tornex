defmodule Torngen.Client.Schema.FactionPact do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :until,
    :faction_name,
    :faction_id
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          until: String.t(),
          faction_name: String.t(),
          faction_id: Torngen.Client.Schema.FactionId.t()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      until: Map.get(data, "until") |> Torngen.Client.Schema.parse({:static, :string}),
      faction_name: Map.get(data, "faction_name") |> Torngen.Client.Schema.parse({:static, :string}),
      faction_id: Map.get(data, "faction_id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionId)
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
