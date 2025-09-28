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

defmodule Tornex.Test.NodeRatelimiter do
  use ExUnit.Case

  test "test_value" do
    {:ok, pid} = ExUnit.Callbacks.start_supervised(Tornex.NodeRatelimiter)

    assert Tornex.NodeRatelimiter.ratelimited?() == false
    Tornex.NodeRatelimiter.set_ratelimited(expires_at: DateTime.utc_now() |> DateTime.add(-10, :second))
    assert Tornex.NodeRatelimiter.ratelimited?() == false
    Tornex.NodeRatelimiter.set_ratelimited(expires_at: DateTime.utc_now() |> DateTime.add(10, :second))
    assert Tornex.NodeRatelimiter.ratelimited?() == true

    DynamicSupervisor.stop(pid)
  end
end
