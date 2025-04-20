defmodule Torngen.Client.Path.Forum.Categories do
  @moduledoc """
  Get publicly available forum categories.

  Requires public access key. <br>

  ## Parmeters

  ## Response
  NYI

  ## Tags
  - Forum
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "forum/categories"

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)
  
  @impl true
  def parameter(parameter_name, _value) when is_atom(parameter_name) do
    :error
  end

  @impl true
  def parameters(), do: @parameter_keys
end