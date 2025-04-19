defmodule Torngen.Client.Path.Forum.ThreadId.Thread do
  @moduledoc """
  Get specific thread details.

  Requires public access key. <br>Contains details of a thread including topic content and poll (if any).

  ## Parmeters
  - threadId: Thread id

  ## Response
  NYI

  ## Tags
  - Forum
  """

  # import Torngen.Client.Path, only: [defparameter: 3]
  require Torngen.Client.Path

  @behaviour Torngen.Client.Path

  @path "forum/{threadId}/thread"

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)
  
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