defmodule Torngen.Client.Path.Torn.Factionhof do
  @moduledoc """
  Get faction hall of fame positions for a specific category.

  Requires public access key. <br> 

  ## Parmeters
  - limit: N/A
  - offset: N/A
  - cat: Leaderboards category

  ## Response
  NYI

  ## Tags
  - Torn
  """

  # import Torngen.Client.Path, only: [defparameter: 3]
  require Torngen.Client.Path

  @behaviour Torngen.Client.Path

  @path "torn/factionhof"

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)
  
  @impl true
  defparameter :limit, value do
    # N/A
    {:query, :limit, value}
  end
  
  @impl true
  defparameter :offset, value do
    # N/A
    {:query, :offset, value}
  end
  
  @impl true
  defparameter :cat, value do
    # Leaderboards category
    {:query, :cat, value}
  end
  
  @impl true
  def parameter(parameter_name, _value) when is_atom(parameter_name) do
    :error
  end

  @impl true
  def parameters(), do: @parameter_keys
end