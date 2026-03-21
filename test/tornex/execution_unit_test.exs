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

defmodule Tornex.Test.ExecutionUnit do
  use ExUnit.Case, async: false

  @api_key Application.compile_env(:tornex, :test_api_key) ||
             raise("The \"TORN_API_KEY\" environment variable must be set for these tests to run")
  @api_key_owner 2_383_326

  test "validate fanout of multiple requests" do
    {:ok, s_pid} = ExUnit.Callbacks.start_supervised({Tornex.Scheduler.Supervisor, timer: false})
    {:ok, n_pid} = ExUnit.Callbacks.start_supervised(Tornex.NodeRatelimiter)

    {:ok, pid} =
      Tornex.Scheduler.bucket_supervisor().start_child(
        Tornex.Scheduler.BucketSupervisor,
        {Tornex.Scheduler.Bucket, user_id: @api_key_owner}
      )

    user_one_profile =
      Tornex.SpecQuery.new()
      |> Tornex.SpecQuery.put_path(Torngen.Client.Path.User.Id.Profile)
      |> Tornex.SpecQuery.put_parameter!(:id, 1)
      |> Tornex.SpecQuery.put_key(@api_key)
      |> Tornex.SpecQuery.put_key_owner(@api_key_owner)

    user_one_bounties =
      Tornex.SpecQuery.new()
      |> Tornex.SpecQuery.put_path(Torngen.Client.Path.User.Id.Bounties)
      |> Tornex.SpecQuery.put_parameter!(:id, 1)
      |> Tornex.SpecQuery.put_key(@api_key)
      |> Tornex.SpecQuery.put_key_owner(@api_key_owner)

    profile_task = Task.async(fn -> Tornex.Scheduler.Bucket.enqueue(user_one_profile) end)
    bounties_task = Task.async(fn -> Tornex.Scheduler.Bucket.enqueue(user_one_bounties) end)

    Process.sleep(5)

    Tornex.Scheduler.Bucket.dump(pid)

    [profile_response, bounties_response] = Task.await_many([profile_task, bounties_task], 60_000)

    assert is_map(profile_response)
    assert is_map_key(profile_response, "profile")
    assert not is_map_key(profile_response, "bounties")
    assert not is_map_key(profile_response, "bounties_timestamp")

    assert is_map(bounties_response)
    assert is_map_key(bounties_response, "bounties")
    assert is_map_key(bounties_response, "bounties_timestamp")
    assert not is_map_key(bounties_response, "profile")

    GenServer.stop(pid)
    GenServer.stop(n_pid)
    Supervisor.stop(s_pid)
  end
end
