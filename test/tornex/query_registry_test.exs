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

defmodule Tornex.Test.QueryRegistry do
  use ExUnit.Case, async: true
  import Tornex.ListAssertions
  alias Tornex.SpecQuery

  test "insert queries with different resources" do
    {:ok, pid} = ExUnit.Callbacks.start_supervised(Tornex.Scheduler.QueryRegistry)

    query_user = SpecQuery.new() |> SpecQuery.put_path(Torngen.Client.Path.User.Basic)
    Tornex.Scheduler.QueryRegistry.insert(query_user)

    query_faction = SpecQuery.new() |> SpecQuery.put_path(Torngen.Client.Path.Faction.Revives)
    Tornex.Scheduler.QueryRegistry.insert(query_faction)

    assert %{
             "user" => %{
               nil => %{
                 "basic" => [^query_user]
               }
             },
             "faction" => %{
               nil => %{
                 "revives" => [^query_faction]
               }
             }
           } = :sys.get_state(pid)

    DynamicSupervisor.stop(pid)
  end

  test "insert queries with different selections" do
    {:ok, pid} = ExUnit.Callbacks.start_supervised(Tornex.Scheduler.QueryRegistry)

    query_basic =
      SpecQuery.new()
      |> SpecQuery.put_path(Torngen.Client.Path.User.Basic)
      |> SpecQuery.put_path(Torngen.Client.Path.User.Attacks)

    Tornex.Scheduler.QueryRegistry.insert(query_basic)

    query_attacks = SpecQuery.new() |> SpecQuery.put_path(Torngen.Client.Path.User.Attacks)
    Tornex.Scheduler.QueryRegistry.insert(query_attacks)

    assert %{
             "user" => %{
               nil => %{
                 "basic" => [^query_basic],
                 "attacks" => [^query_attacks, ^query_basic]
               }
             }
           } = :sys.get_state(pid)

    DynamicSupervisor.stop(pid)
  end

  test "insert queries with different resource IDs" do
    {:ok, pid} = ExUnit.Callbacks.start_supervised(Tornex.Scheduler.QueryRegistry)

    query_one =
      SpecQuery.new()
      |> SpecQuery.put_path(Torngen.Client.Path.User.Id.Basic)
      |> SpecQuery.put_path(Torngen.Client.Path.User.Id.Bounties)
      |> SpecQuery.put_parameter(:id, 1)

    Tornex.Scheduler.QueryRegistry.insert(query_one)

    query_two =
      SpecQuery.new()
      |> SpecQuery.put_path(Torngen.Client.Path.User.Id.Basic)
      |> Tornex.SpecQuery.put_parameter(:id, 2)

    Tornex.Scheduler.QueryRegistry.insert(query_two)

    assert %{
             "user" => %{
               {:id, 1} => %{"basic" => [^query_one], "bounties" => [^query_one]},
               {:id, 2} => %{"basic" => [^query_two]}
             }
           } = :sys.get_state(pid)

    DynamicSupervisor.stop(pid)
  end

  test "pull similar overlapping queries with no resource ID" do
    # Public selections for no resource ID and the same key owner (applying as the resource ID
    # for user resources) should be combined.

    query_one =
      SpecQuery.new(key_owner: 1)
      |> SpecQuery.put_path(Torngen.Client.Path.User.Basic)

    query_two =
      SpecQuery.new(key_owner: 1)
      |> SpecQuery.put_path(Torngen.Client.Path.User.Bounties)

    state = %{
      "user" => %{
        nil => %{
          "basic" => [query_one],
          "bounties" => [query_two]
        }
      }
    }

    similar_one = Tornex.Scheduler.QueryRegistry.find_similar(query_one, state)
    similar_two = Tornex.Scheduler.QueryRegistry.find_similar(query_two, state)
    assert_unordered([^query_one, ^query_two], similar_one)
    assert_unordered([^query_one, ^query_two], similar_two)
  end

  test "pull similar non-overlapping queries with no resource ID and different key owners" do
    # These queries are not overlapping as they do not have a resource ID so the resource owner is 
    # the resource ID the operation is running against.

    query_one =
      SpecQuery.new(key_owner: 1)
      |> SpecQuery.put_path(Torngen.Client.Path.User.Basic)

    query_two =
      SpecQuery.new(key_owner: 2)
      |> SpecQuery.put_path(Torngen.Client.Path.User.Basic)

    state = %{
      "user" => %{
        nil => %{
          "basic" => [query_one, query_two],
        }
      }
    }

    similar_one = Tornex.Scheduler.QueryRegistry.find_similar(query_one, state)
    similar_two = Tornex.Scheduler.QueryRegistry.find_similar(query_two, state)
    assert_unordered([^query_one], similar_one)
    assert_unordered([^query_two], similar_two)
  end

  test "pull similar overlapping queries with no resource ID and different key owners" do
    # These queries are overlapping despite not having a resource ID and different key
    # owners as the data is shared globally across all users.

    query_one =
      SpecQuery.new(key_owner: 1)
      |> SpecQuery.put_path(Torngen.Client.Path.Torn.Crimes)

    query_two =
      SpecQuery.new(key_owner: 1)
      |> SpecQuery.put_path(Torngen.Client.Path.Torn.Items)

    state = %{
      "torn" => %{
        nil => %{
          "crimes" => [query_one],
          "items" => [query_two]
        }
      }
    }

    similar_one = Tornex.Scheduler.QueryRegistry.find_similar(query_one, state)
    similar_two = Tornex.Scheduler.QueryRegistry.find_similar(query_two, state)
    assert_unordered([^query_one, ^query_two], similar_one)
    assert_unordered([^query_one, ^query_two], similar_two)
  end

  test "pull similar overlapping queries with the same resource ID" do
    query_one =
      SpecQuery.new(key_owner: 1)
      |> SpecQuery.put_path(Torngen.Client.Path.User.Id.Basic)
      |> SpecQuery.put_parameter(:id, 2383326)

    query_two =
      SpecQuery.new(key_owner: 1)
      |> SpecQuery.put_path(Torngen.Client.Path.User.Id.Faction)
      |> SpecQuery.put_parameter(:id, 2383326)

    state = %{
      "user" => %{
        {:id, 2383326} => %{
          "basic" => [query_one],
          "faction" => [query_two]
        }
      }
    }

    similar_one = Tornex.Scheduler.QueryRegistry.find_similar(query_one, state)
    similar_two = Tornex.Scheduler.QueryRegistry.find_similar(query_two, state)
    assert_unordered([^query_one, ^query_two], similar_one)
    assert_unordered([^query_one, ^query_two], similar_two)
  end

  test "pull similar non-overlapping with different resource IDs" do
    query_one =
      SpecQuery.new(key_owner: 1)
      |> SpecQuery.put_path(Torngen.Client.Path.User.Id.Basic)
      |> SpecQuery.put_parameter(:id, 2383326)

    query_two =
      SpecQuery.new(key_owner: 1)
      |> SpecQuery.put_path(Torngen.Client.Path.User.Id.Basic)
      |> SpecQuery.put_parameter(:id, 1)

    state = %{
      "user" => %{
        {:id, 2383326} => %{
          "basic" => [query_one],
        },
        {:id, 1} => %{
          "basic" => [query_two]
        }
      }
    }

    similar_one = Tornex.Scheduler.QueryRegistry.find_similar(query_one, state)
    similar_two = Tornex.Scheduler.QueryRegistry.find_similar(query_two, state)
    assert_unordered([^query_one], similar_one)
    assert_unordered([^query_two], similar_two)
  end
end
