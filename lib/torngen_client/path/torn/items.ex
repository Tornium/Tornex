defmodule Torngen.Client.Path.Torn.Items do
  @moduledoc """
  Get information about items.

  Requires public key.<br>Default category is 'All'.<br>Details are not populated when requesting the category 'All'.

  ## Parmeters
  - cat: Item category type
  - sort: Sort rows from newest to oldest<br>Default ordering is ascending

  ## Tags
  - Torn
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "torn/items"

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)

  @impl true
  defparameter :cat, value do
    # Item category type
    {:query, :cat, value}
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
