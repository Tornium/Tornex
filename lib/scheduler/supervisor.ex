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

defmodule Tornex.Scheduler.Supervisor do
  @moduledoc """
  Default supervisor to supervise `Tornex.Scheduler.Bucket`, the dump timer, and the bucket registry.
  The `Supervisor` can be replaced if necessary to modify bucket storage, the dump timer, etc.
  """

  use DynamicSupervisor

  @doc """
  Starts the `DynamicSupervisor` required for enqueuing a `Tornex.Query`.
  """
  def start_link(args \\ []) do
    # TODO: Refactor into a Supervisor with static supervisors and children underneath it

    {:ok, pid} = DynamicSupervisor.start_link(__MODULE__, args, name: __MODULE__)

    {:ok, _} = DynamicSupervisor.start_child(pid, {Task.Supervisor, name: Tornex.Scheduler.TaskSupervisor})
    {:ok, _} = DynamicSupervisor.start_child(pid, Tornex.Scheduler.Timer)
    {:ok, _} = DynamicSupervisor.start_child(pid, {Registry, name: Tornex.Scheduler.BucketRegistry, keys: :unique})

    {:ok, pid}
  end

  @doc false
  @impl true
  def init(_init_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
