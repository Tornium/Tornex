defmodule Torngen.Client.Path.Torn.TerritoryIds.Territory do
  @moduledoc """
  Get territory details.

  Requires public access key. <br>

  ## Parmeters
  - territoryIds: Territory id or a list of territory ids (comma separated)
  - timestamp: Timestamp to bypass cache
  - comment: Comment for your tool/service/bot/website to be visible in the logs.
  - key: API key (Public).<br>It's not required to use this parameter when passing the API key via the Authorization header.

  ## Tags
  - Torn
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "torn/{territoryIds}/territory"
  @response_modules [TornTerritoriesResponse]

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
  defparameter :timestamp, value do
    # Timestamp to bypass cache
    {:query, :timestamp, value}
  end

  @impl true
  defparameter :comment, value do
    # Comment for your tool/service/bot/website to be visible in the logs.
    {:query, :comment, value}
  end

  @impl true
  defparameter :key, value do
    # API key (Public).<br>It's not required to use this parameter when passing the API key via the Authorization header.
    {:query, :key, value}
  end

  @impl true
  def parameter(parameter_name, _value) when is_atom(parameter_name) do
    :error
  end

  @impl true
  def parameters(), do: @parameter_keys

  @impl true
  def parse(response), do: Torngen.Client.Path.parse(@response_modules, response)
end
