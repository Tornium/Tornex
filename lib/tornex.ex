defmodule Tornex do
  @moduledoc false

  @force_local? Application.compile_env(:tornex, :local, true)

  @doc """
  Determine if Tornex is running locally or on a cluster.
  """
  @spec local?() :: boolean()
  def local?() do
    not Code.ensure_loaded?(Horde.DynamicSupervisor) or not Code.ensure_loaded?(Horde.Registry) or @force_local?
  end
end
