defmodule Torngen.Client.Path.User.Id.Bounties do
  @moduledoc """
  Get bounties placed on a specific user.

  Requires public access key. <br>

  ## Parmeters
  - id: User id

  ## Tags
  - User
  """

  import Torngen.Client.Path, only: [defparameter: 3]

  @behaviour Torngen.Client.Path

  @path "user/{id}/bounties"

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
