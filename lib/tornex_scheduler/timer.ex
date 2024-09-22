# Copyright 2024 tiksan
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

defmodule Tornex.Scheduler.Timer do
  use GenServer

  # 15 seconds
  @timer_interval 15_000

  # Public API
  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  # GenServer Callbacks
  def init(_opts) do
    :timer.send_interval(@timer_interval, :dump_signal)

    {:ok, %{}}
  end

  def handle_info(:dump_signal, state) do
    children = DynamicSupervisor.which_children(Tornex.Scheduler.Supervisor)

    Enum.each(children, fn
      {_, pid, :worker, _} ->
        send(pid, :dump)

      _ ->
        :ok
    end)

    {:noreply, state}
  end

  def handle_info(:dump, state) do
    {:noreply, state}
  end
end
