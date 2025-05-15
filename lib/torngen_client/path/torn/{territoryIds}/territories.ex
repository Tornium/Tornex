defmodule Torngen.Client.Path.Torn.TerritoryIds.Territories do
  @moduledoc """
  Get territory details.

  Requires public access key. <br>

  ## Parmeters
  - territoryIds: Territory id or a list of territory ids (comma separated)

  ## Tags
  - Torn
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "torn/{territoryIds}/territories"

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)

  @impl true
  defparameter :territoryIds, value do
    # Territory id or a list of territory ids (comma separated)
    {:path, :territoryIds, value}
  end

  @impl true
  def parameter(parameter_name, _value) when is_atom(parameter_name) do
    :error
  end

  @impl true
  def parameters(), do: @parameter_keys
end
