defmodule Tornex do
  @moduledoc false

  @clustered? Code.ensure_loaded?(Horde.DynamicSupervisor) and Code.ensure_loaded?(Horde.Registry) and
                not Application.compile_env(:tornex, :local, true)

  @doc """
  Determine if Tornex is running locally or on a cluster.
  """
  @spec local?() :: boolean()
  def local?(), do: not @clustered?
end
