defmodule Torngen.Client.Path.User.Forumthreads do
  @moduledoc """
  Get your threads.

  Requires public access key. <br>Returns 100 threads per page. The field 'new_posts' is also available, indicating the amount of unread posts with a Minimum API key (or higher).

  ## Parmeters
  - limit: N/A
  - sort: Sorted by the greatest timestamps
  - from: Timestamp that sets the lower limit for the data returned
  - to: Timestamp that sets the upper limit for the data returned

  ## Response
  NYI

  ## Tags
  - User
  """

  # import Torngen.Client.Path, only: [defparameter: 3]
  require Torngen.Client.Path

  @behaviour Torngen.Client.Path

  @path "user/forumthreads"

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
  defparameter :sort, value do
    # Sorted by the greatest timestamps
    {:query, :sort, value}
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
  def parameter(parameter_name, _value) when is_atom(parameter_name) do
    :error
  end

  @impl true
  def parameters(), do: @parameter_keys
end