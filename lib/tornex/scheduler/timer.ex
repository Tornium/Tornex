# Copyright 2024-2025 tiksan
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
  @moduledoc """
  Timer used to determine when to dump all of the buckets, see `Tornex.Scheduler.Bucket`.
  By default, the bucket will be dumped every 15 seconds to allow for a maximum call rate of 
  60 API requests per minute. Upon the dump timer ending, the GenServer will send a `:dump` signal to 
  all `Tornex.Scheduler.Bucket` under `Tornex.Scheduler.Supervisor`.
  """

  use GenServer

  @timer_interval 15_000

  @doc """
  Starts the `GenServer` for the `Tornex.Scheduler.Bucket` dump timer.
  """
  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  @doc false
  def init(_opts) do
    :timer.send_interval(@timer_interval, :dump_signal)

    {:ok, %{}}
  end

  @doc false
  def handle_info(:dump_signal, state) do
    children = DynamicSupervisor.which_children(Tornex.Scheduler.BucketSupervisor)
    # TODO: Determine if each node will have its own dump timer for its own bucket supervisor

    Enum.each(children, fn
      {_, pid, :worker, _} ->
        send(pid, :dump)

      _ ->
        :ok
    end)

    {:noreply, state}
  end

  @doc false
  def handle_info(:dump, state) do
    # Fake handler to prevent errors when `handle_info(:dump_signal, _)` also sends the signal to this GenServer
    {:noreply, state}
  end
end
