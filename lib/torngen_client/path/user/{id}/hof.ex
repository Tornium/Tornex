defmodule Torngen.Client.Path.User.Id.Hof do
  @moduledoc """
  Get hall of fame rankings for a specific player.

  Requires public access key. <br>The battle_stats selection will be populated only when requesting selection with Limited, Full or Custom key and for yourself.

  ## Parmeters
  - id: User id

  ## Response
  NYI

  ## Tags
  - User
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "user/{id}/hof"

  Module.register_attribute(__MODULE__, :parameter_keys, accumulate: true)

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)
  
  @impl true
  defparameter :id, value do
    # User id
    {:path, :id, value}
  end
  
  @impl true
  def parameter(parameter_name, _value) when is_atom(parameter_name) do
    :error
  end

  @impl true
  def parameters(), do: @parameter_keys
end