defmodule Torngen.Client.Path.Market do
  @moduledoc """
  Get any Market selection.

  Requires public access key. <br>Choose one or more selections (comma separated).

  ## Parmeters
  - selections: Selection names
  - id: selection id
  - bonus: Used to filter weapons with a specific bonus
  - cat: Selection category
  - sort: Direction to sort rows in
  - offset: N/A

  ## Response
  NYI

  ## Tags
  - Market
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "market"

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)
  
  @impl true
  defparameter :selections, value do
    # Selection names
    {:query, :selections, value}
  end
  
  @impl true
  defparameter :id, value do
    # selection id
    {:query, :id, value}
  end
  
  @impl true
  defparameter :bonus, value do
    # Used to filter weapons with a specific bonus
    {:query, :bonus, value}
  end
  
  @impl true
  defparameter :cat, value do
    # Selection category
    {:query, :cat, value}
  end
  
  @impl true
  defparameter :sort, value do
    # Direction to sort rows in
    {:query, :sort, value}
  end
  
  @impl true
  defparameter :offset, value do
    # N/A
    {:query, :offset, value}
  end
  
  @impl true
  def parameter(parameter_name, _value) when is_atom(parameter_name) do
    :error
  end

  @impl true
  def parameters(), do: @parameter_keys
end