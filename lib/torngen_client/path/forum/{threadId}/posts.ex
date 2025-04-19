defmodule Torngen.Client.Path.Forum.ThreadId.Posts do
  @moduledoc """
  Get specific forum thread posts.

  Requires public access key. <br>Returns 20 posts per page for a specific thread.

  ## Parmeters
  - offset: N/A
  - striptags: Determines if fields include HTML or not ('Hospitalized by <a href=...>user</a>' vs 'Hospitalized by user').
  - threadId: Thread id

  ## Response
  NYI

  ## Tags
  - Forum
  """

  # import Torngen.Client.Path, only: [defparameter: 3]
  require Torngen.Client.Path

  @behaviour Torngen.Client.Path

  @path "forum/{threadId}/posts"

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)
  
  @impl true
  defparameter :offset, value do
    # N/A
    {:query, :offset, value}
  end
  
  @impl true
  defparameter :striptags, value do
    # Determines if fields include HTML or not ('Hospitalized by <a href=...>user</a>' vs 'Hospitalized by user').
    {:query, :striptags, value}
  end
  
  @impl true
  defparameter :threadId, value do
    # Thread id
    {:path, :threadId, value}
  end
  
  @impl true
  def parameter(parameter_name, _value) when is_atom(parameter_name) do
    :error
  end

  @impl true
  def parameters(), do: @parameter_keys
end