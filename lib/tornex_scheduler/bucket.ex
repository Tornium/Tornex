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

defmodule Tornex.Scheduler.Bucket do
  use GenServer

  # Public API
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @spec enqueue(pid :: pid(), query :: Tornex.Query.t()) :: any()
  def enqueue(pid, query) do
    GenServer.call(pid, {:enqueue, query}, 60_000)
  end

  # GenServer Callbacks
  @impl true
  def init(_opts) do
    {:ok, %{query_priority_queue: [], pending_count: 0}}
  end

  @impl true
  def handle_call(
        {:enqueue, query},
        from,
        %{query_priority_queue: query_priority_queue, pending_count: pending_count} = state
      ) do
    cond do
      Tornex.Query.query_priority(query) == :user_request and pending_count < 10 ->
        # Request has a niceness indicating it's a user request and there's available space in the 
        # bucket to perform the request

        make_request(query, from)
        Map.replace(state, :pending_count, pending_count + 1)
        {:noreply, state}

      Tornex.Query.query_priority(query) in [:user_request, :high_priority] and pending_count < 7 ->
        # Request has a niceness indicating it's a user request or high priority and there's available 
        # space in the bucket to perform the request

        make_request(query, from)
        Map.replace(state, :pending_count, pending_count + 1)
        {:noreply, state}

      true ->
        # Either:
        #  - Request has a niceness indicating it's a user request or high priority request but there's not 
        #    available space in the bucket to perform the request and thus is queued
        #  - Request has a niceness of greater than 0 and therefore isn't high enough priority and should
        #    be queued

        # Sorts inserted query with higher priority queries at the start
        updated_queue = Enum.sort_by([query | query_priority_queue], & &1.nice, :asc)
        Map.replace(state, :query_priority_queue, updated_queue)
        {:noreply, state}
    end
  end

  @impl true
  def handle_info(_msg, state) do
    {:noreply, state}
  end

  # Utility functions
  defp make_request_task(query, from) do
    GenServer.reply(from, Tornex.API.torn_get(query))
  end

  def make_request(query, from) do
    # TODO: Use partition supervisor
    Task.Supervisor.async_nolink(Tornex.Scheduler.TaskSupervisor, fn ->
      make_request_task(query, from)
    end)
  end
end

# TODO: Add custom await_many that won't error on timeouts
# TODO: Add custom await_many that won't error on timeouts and has a callback
