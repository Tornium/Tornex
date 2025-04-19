defmodule Torngen.Client.Path.Faction.News do
  @moduledoc """
  Get your faction's news details.

  Requires minimal access key with faction API access permissions. <br> It is possible to pass up to 10 categories at the time (comma separated). Categories 'attack', 'depositFunds' and 'giveFunds' are only available with 'Custom', 'Limited' or 'Full' access keys.

  ## Parmeters
  - striptags: Determines if fields include HTML or not ('Hospitalized by <a href=...>user</a>' vs 'Hospitalized by user').
  - limit: N/A
  - sort: Sorted by the greatest timestamps
  - to: Timestamp that sets the upper limit for the data returned
  - from: Timestamp that sets the lower limit for the data returned
  - cat: News category type

  ## Response
  NYI

  ## Tags
  - Faction
  """

  # import Torngen.Client.Path, only: [defparameter: 3]
  require Torngen.Client.Path

  @behaviour Torngen.Client.Path

  @path "faction/news"

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)
  
  @impl true
  defparameter :striptags, value do
    # Determines if fields include HTML or not ('Hospitalized by <a href=...>user</a>' vs 'Hospitalized by user').
    {:query, :striptags, value}
  end
  
  @impl true
  defparameter :limit, value do
    # N/A
    {:query, :limit, value}
  end
  
  @impl true
  defparameter :sort, value do
    # Sorted by the greatest timestamps
    {:query, :sort, value}
  end
  
  @impl true
  defparameter :to, value do
    # Timestamp that sets the upper limit for the data returned. Data returned will be up to and including this time
    {:query, :to, value}
  end
  
  @impl true
  defparameter :from, value do
    # Timestamp that sets the lower limit for the data returned. Data returned will be after this time
    {:query, :from, value}
  end
  
  @impl true
  defparameter :cat, value do
    # News category type
    {:query, :cat, value}
  end
  
  @impl true
  def parameter(parameter_name, _value) when is_atom(parameter_name) do
    :error
  end

  @impl true
  def parameters(), do: @parameter_keys
end