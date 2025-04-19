defmodule Torngen.Client.Path.User do
  @moduledoc """
  Get any User selection.

  Key access level depends on the required selections. <br>Choose one or more selections (comma separated).

  ## Parmeters
  - selections: Selection names
  - id: selection id
  - limit: N/A
  - from: Timestamp that sets the lower limit for the data returned
  - to: Timestamp that sets the upper limit for the data returned
  - sort: Sorted by the greatest timestamps
  - cat: Selection category
  - stat: Selection stat
  - striptags: Determines if fields include HTML or not ('Hospitalized by <a href=...>user</a>' vs 'Hospitalized by user').
  - offset: N/A

  ## Response
  NYI

  ## Tags
  - User
  """

  # import Torngen.Client.Path, only: [defparameter: 3]
  require Torngen.Client.Path

  @behaviour Torngen.Client.Path

  @path "user"

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
  defparameter :limit, value do
    # N/A
    {:query, :limit, value}
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
  defparameter :cat, value do
    # Selection category
    {:query, :cat, value}
  end
  
  @impl true
  defparameter :stat, value do
    # Selection stat
    {:query, :stat, value}
  end
  
  @impl true
  defparameter :striptags, value do
    # Determines if fields include HTML or not ('Hospitalized by <a href=...>user</a>' vs 'Hospitalized by user').
    {:query, :striptags, value}
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