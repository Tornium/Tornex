defmodule Tornex.Scheduler do
  @moduledoc false

  @spec bucket_registry() :: module()
  def bucket_registry() do
    if Tornex.local?() do
      Registry
    else
      Horde.Registry
    end
  end

  @spec bucket_supervisor() :: module()
  def bucket_supervisor() do
    if Tornex.local?() do
      DynamicSupervisor
    else
      Horde.DynamicSupervisor
    end
  end
end
