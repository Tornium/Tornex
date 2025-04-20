defmodule Torngen.Client.Path.User.Calendar do
  @moduledoc """
  Get your competition's event start time.

  Requires minimal access key. <br>Only available to yourself.

  ## Parmeters

  ## Tags
  - User
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "user/calendar"

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
