defmodule Torngen.Client.Path.Faction.Rankedwars do
  @moduledoc """
  Get ranked wars list.

  Requires public access key. <br> When category 'all' is chosen, you can use 'from', 'to' & 'sort' query parameters.<br>When category 'ongoing' is chosen, all currently active ranked wars are returned.<br>When no category is chosen, this selection will return ranked war history of your own faction (if any).

  ## Parmeters
  - cat: Stats category
  - from: Timestamp that sets the lower limit for the data returned
  - to: Timestamp that sets the upper limit for the data returned
  - sort: Sorted by the greatest timestamps

  ## Response
  NYI

  ## Tags
  - Faction
  """

  # import Torngen.Client.Path, only: [defparameter: 3]
  require Torngen.Client.Path

  @behaviour Torngen.Client.Path

  @path "faction/rankedwars"

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)
  
  @impl true
  defparameter :cat, value do
    # Stats category. Required unless requesting specific stats via 'stat' query parameter
    {:query, :cat, value}
  end
  
  @impl true
  defparameter :from, value do
    # Timestamp that sets the lower limit for the data returned. Data returned will be after this time
    {:query, :from, value}
  end
  
  @impl true
  defparameter :to, value do
    # Timestamp that sets the upper limit for the data returned. Data returned will be up to and including this time
    {:query, :to, value}
  end
  
  @impl true
  defparameter :sort, value do
    # Sorted by the greatest timestamps
    {:query, :sort, value}
  end
  
  @impl true
  def parameter(parameter_name, _value) when is_atom(parameter_name) do
    :error
  end

  @impl true
  def parameters(), do: @parameter_keys
end