defmodule Torngen.Client.Path.User.List do
  @moduledoc """
  Get your friends, enemies or targets list.

  Requires limited access key. <br>

  ## Parmeters
  - cat: Select list type
  - limit: N/A
  - offset: N/A
  - sort: Sort rows from newest to oldest<br>Default ordering is ascending

  ## Response
  NYI

  ## Tags
  - User
  """

  # import Torngen.Client.Path, only: [defparameter: 3]
  require Torngen.Client.Path

  @behaviour Torngen.Client.Path

  @path "user/list"

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)
  
  @impl true
  defparameter :cat, value do
    # Select list type
    {:query, :cat, value}
  end
  
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