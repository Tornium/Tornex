defmodule Torngen.Client.Path.Faction.ChainId.Chainreport do
  @moduledoc """
  Get a chain report.

  Requires public access key. <br> Chain reports for ongoing chains are available only for your own faction.

  ## Parmeters
  - chainId: Chain id

  ## Response
  NYI

  ## Tags
  - Faction
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "faction/{chainId}/chainreport"

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)
  
  @impl true
  defparameter :chainId, value do
    # Chain id
    {:path, :chainId, value}
  end
  
  @impl true
  def parameter(parameter_name, _value) when is_atom(parameter_name) do
    :error
  end

  @impl true
  def parameters(), do: @parameter_keys
end