defmodule Torngen.Client.Schema.FactionOngoingChain do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :timeout,
    :start,
    :modifier,
    :max,
    :id,
    :end,
    :current,
    :cooldown
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          timeout: integer(),
          start: integer(),
          modifier: integer() | float(),
          max: integer(),
          id: Torngen.Client.Schema.ChainId.t(),
          end: integer(),
          current: integer(),
          cooldown: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      timeout: Map.get(data, "timeout") |> Torngen.Client.Schema.parse({:static, :integer}),
      start: Map.get(data, "start") |> Torngen.Client.Schema.parse({:static, :integer}),
      modifier: Map.get(data, "modifier") |> Torngen.Client.Schema.parse({:static, :number}),
      max: Map.get(data, "max") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ChainId),
      end: Map.get(data, "end") |> Torngen.Client.Schema.parse({:static, :integer}),
      current: Map.get(data, "current") |> Torngen.Client.Schema.parse({:static, :integer}),
      cooldown: Map.get(data, "cooldown") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
