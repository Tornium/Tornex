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

defmodule Tornex.Test.Scheduler do
  @test_api_key "asdf1234asdf1234"

  use ExUnit.Case

  test "test_start_supervisor" do
    {:ok, s_pid} = ExUnit.Callbacks.start_supervised(Tornex.Scheduler.Supervisor)
    DynamicSupervisor.stop(s_pid)
  end

  test "test_genserver_single" do
    {:ok, s_pid} = ExUnit.Callbacks.start_supervised(Tornex.Scheduler.Supervisor)
    {:ok, n_pid} = ExUnit.Callbacks.start_supervised(Tornex.NodeRatelimiter)

    {:ok, pid} =
      Tornex.Scheduler.bucket_supervisor().start_child(Tornex.Scheduler.BucketSupervisor, Tornex.Scheduler.Bucket)


    %{"error" => %{"code" => 2}} =
      Tornex.Scheduler.Bucket.enqueue(
        pid,
        %Tornex.Query{
          resource: "user",
          resource_id: 1,
          key: @test_api_key,
          key_owner: 2_383_326,
          nice: 0
        },
        []
      )

    GenServer.stop(pid)
    Supervisor.stop(s_pid)
  end

  test "test_genserver_multiple" do
    {:ok, s_pid} = ExUnit.Callbacks.start_supervised(Tornex.Scheduler.Supervisor)
    {:ok, n_pid} = ExUnit.Callbacks.start_supervised(Tornex.NodeRatelimiter)

    {:ok, pid} =
      Tornex.Scheduler.bucket_supervisor().start_child(Tornex.Scheduler.BucketSupervisor, Tornex.Scheduler.Bucket)

    1..10
    |> Enum.map(fn n ->
      Task.async(fn ->
        Tornex.Scheduler.Bucket.enqueue(
          pid,
          %Tornex.Query{
            resource: "user",
            resource_id: n,
            key: @test_api_key,
            key_owner: 2_383_326,
            nice: -5
          },
          []
        )
      end)
    end)
    |> Task.await_many(60_000)

    GenServer.stop(pid)
    Supervisor.stop(s_pid)
  end

  test "test_genserver_multiple_low_priority" do
    {:ok, s_pid} = ExUnit.Callbacks.start_supervised(Tornex.Scheduler.Supervisor)
    {:ok, n_pid} = ExUnit.Callbacks.start_supervised(Tornex.NodeRatelimiter)

    {:ok, pid} =
      Tornex.Scheduler.bucket_supervisor().start_child(Tornex.Scheduler.BucketSupervisor, Tornex.Scheduler.Bucket)

    1..10
    |> Enum.map(fn n ->
      Task.async(fn ->
        Tornex.Scheduler.Bucket.enqueue(
          pid,
          %Tornex.Query{
            resource: "user",
            resource_id: n,
            key: @test_api_key,
            key_owner: 2_383_326,
            nice: 0 + n
          },
          []
        )
      end)
    end)
    |> Task.await_many(60_000)

    GenServer.stop(pid)
    Supervisor.stop(s_pid)
  end

  test "test_genserver_new_bucket" do
    {:ok, s_pid} = ExUnit.Callbacks.start_supervised(Tornex.Scheduler.Supervisor)
    {:ok, n_pid} = ExUnit.Callbacks.start_supervised(Tornex.NodeRatelimiter)

    {:ok, pid} =
      Tornex.Scheduler.bucket_supervisor().start_child(Tornex.Scheduler.BucketSupervisor, Tornex.Scheduler.Bucket)

    %{"error" => %{"code" => 2}} =
      Tornex.Scheduler.Bucket.enqueue(
        %Tornex.Query{
          resource: "user",
          resource_id: 1,
          key: @test_api_key,
          key_owner: 2_383_326,
          nice: 0
        },
        []
      )

    GenServer.stop(pid)
    Supervisor.stop(s_pid)
  end
end
