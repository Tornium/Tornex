defmodule Torngen.Client.Path.Torn.Ids.Items do
  @moduledoc """
  Get information about items.

  Requires public key.<br>Details are always populated when available.

  ## Parmeters
  - ids: Item id or a list of item ids (comma separated)
  - sort: Sort rows from newest to oldest<br>Default ordering is ascending

  ## Response
  NYI

  ## Tags
  - Torn
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "torn/{ids}/items"

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)
  
  @impl true
  defparameter :ids, value do
    # Item id or a list of item ids (comma separated)
    {:path, :ids, value}
  end
  
  @impl true
  defparameter :sort, value do
    # Sort rows from newest to oldest<br>Default ordering is ascending
    {:query, :sort, value}
  end
  
  @impl true
  def parameter(parameter_name, _value) when is_atom(parameter_name) do
    :error
  end

  @impl true
  def parameters(), do: @parameter_keys
end