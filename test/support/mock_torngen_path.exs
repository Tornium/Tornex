defmodule Tornex.Mock.TorngenPath do
  @moduledoc """
  Mock Torngen-generated path.
  """

  @behaviour Torngen.Client.Path

  @path "faction/basic"

  @impl true
  def path(), do: @path

  @impl true
  def path_selection(), do: Torngen.Client.Path.path_selection(@path)

  @impl true
  def parameter(parameter_name, _value) when is_atom(parameter_name) do
    :error
  end
end
