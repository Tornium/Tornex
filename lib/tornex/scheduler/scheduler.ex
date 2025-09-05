defmodule Tornex.Scheduler do
  @moduledoc false

  @spec bucket_supervisor() :: module()
  def bucket_supervisor() do
    if Tornex.local?() do
      DynamicSupervisor
    else
      Horde.DynamicSupervisor
    end
  end
end
