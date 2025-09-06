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

  use Supervisor

  @doc """
  Starts the `Supervisor` required for enqueuing queries.
  """
  def start_link(args \\ []) do
    Supervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  @doc false
  @impl true
  def init(_args \\ []) do
    children = [
      {Task.Supervisor, name: Tornex.Scheduler.TaskSupervisor},
      Tornex.Scheduler.Timer,
      {
        Tornex.Scheduler.bucket_supervisor(),
        name: Tornex.Scheduler.BucketSupervisor, strategy: :one_for_one, members: :auto, process_redistribution: :active
      },
      {Tornex.Scheduler.bucket_registry(), name: Tornex.Scheduler.BucketRegistry, members: :auto, keys: :unique}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
