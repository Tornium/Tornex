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
  alias Tornex.Scheduler.ExecutionUnit

  test "insert queries with different resources" do
    {:ok, pid} = ExUnit.Callbacks.start_supervised(Tornex.Scheduler.QueryRegistry)

    query_user =
      SpecQuery.new()
      |> SpecQuery.put_path(Torngen.Client.Path.User.Basic)
      |> then(&%{&1 | origin: self()})

    query_faction =
      SpecQuery.new()
      |> SpecQuery.put_path(Torngen.Client.Path.Faction.Revives)
      |> then(&%{&1 | origin: self()})

    Tornex.Scheduler.QueryRegistry.insert(query_user)
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
      |> then(&%{&1 | origin: self()})

    query_attacks =
      SpecQuery.new()
      |> SpecQuery.put_path(Torngen.Client.Path.User.Attacks)
      |> then(&%{&1 | origin: self()})

    Tornex.Scheduler.QueryRegistry.insert(query_basic)
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
      |> SpecQuery.put_parameter!(:id, 1)
      |> then(&%{&1 | origin: self()})

    query_two =
      SpecQuery.new()
      |> SpecQuery.put_path(Torngen.Client.Path.User.Id.Basic)
      |> Tornex.SpecQuery.put_parameter!(:id, 2)
      |> then(&%{&1 | origin: self()})

    Tornex.Scheduler.QueryRegistry.insert(query_one)
    Tornex.Scheduler.QueryRegistry.insert(query_two)

    assert %{
             "user" => %{
               {:id, 1} => %{"basic" => [^query_one], "bounties" => [^query_one]},
               {:id, 2} => %{"basic" => [^query_two]}
             }
           } = :sys.get_state(pid)

    DynamicSupervisor.stop(pid)
  end

  test "insert queries with fallback resource IDs" do
    {:ok, pid} = ExUnit.Callbacks.start_supervised(Tornex.Scheduler.QueryRegistry)

    query_one =
      SpecQuery.new()
      |> SpecQuery.put_path(Torngen.Client.Path.User.Id.Basic)
      |> SpecQuery.put_path(Torngen.Client.Path.User.Id.Bounties)
      |> SpecQuery.put_parameter!(:id, 1)
      |> then(&%{&1 | origin: self()})

    query_two =
      SpecQuery.new(resource_id: {:id, 1})
      |> SpecQuery.put_path(Torngen.Client.Path.User.Basic)
      |> SpecQuery.put_path(Torngen.Client.Path.User.Equipment)
      |> then(&%{&1 | origin: self()})

    Tornex.Scheduler.QueryRegistry.insert(query_one)
    Tornex.Scheduler.QueryRegistry.insert(query_two)

    assert %{
             "user" => %{
               {:id, 1} => %{"basic" => basic_queries, "bounties" => [^query_one], "equipment" => [^query_two]}
             }
           } = :sys.get_state(pid)

    assert_unordered([^query_one, query_two], basic_queries)

    DynamicSupervisor.stop(pid)
  end

  test "merge similar overlapping queries with no resource ID" do
    # Public selections for no resource ID and the same key owner (applying as the resource ID
    # for user resources) should be combined.

    query_one =
      SpecQuery.new(key_owner: 1)
      |> SpecQuery.put_path(Torngen.Client.Path.User.Basic)
      |> then(&%{&1 | origin: self()})

    query_two =
      SpecQuery.new(key_owner: 1)
      |> SpecQuery.put_path(Torngen.Client.Path.User.Bounties)
      |> then(&%{&1 | origin: self()})

    state = %{
      "user" => %{
        nil => %{
          "basic" => [query_one],
          "bounties" => [query_two]
        }
      }
    }

    similar_one = Tornex.Scheduler.QueryRegistry.merge_similar(query_one, state)
    similar_two = Tornex.Scheduler.QueryRegistry.merge_similar(query_two, state)

    assert %ExecutionUnit{
             parameters: [],
             key_owner: 1,
             nice: 20
           } = similar_one

    assert_unordered([Torngen.Client.Path.User.Basic, Torngen.Client.Path.User.Bounties], similar_one.paths)
    assert_unordered([^query_one, ^query_two], similar_one.parents)

    assert %ExecutionUnit{
             parameters: [],
             key_owner: 1,
             nice: 20
           } = similar_two

    assert_unordered([Torngen.Client.Path.User.Basic, Torngen.Client.Path.User.Bounties], similar_two.paths)
    assert_unordered([^query_one, ^query_two], similar_two.parents)
  end

  test "merge similar overlapping queries with fallback resource IDs" do
    # Public selections for no resource ID and the same key owner (applying as the resource ID
    # for user resources) should be combined.

    query_one =
      SpecQuery.new(key_owner: 1, resource_id: {:id, 1})
      |> SpecQuery.put_path(Torngen.Client.Path.User.Basic)
      |> then(&%{&1 | origin: self()})

    query_two =
      SpecQuery.new(key_owner: 1, resource_id: {:id, 1})
      |> SpecQuery.put_path(Torngen.Client.Path.User.Bounties)
      |> then(&%{&1 | origin: self()})

    state = %{
      "user" => %{
        {:id, 1} => %{
          "basic" => [query_one],
          "bounties" => [query_two]
        }
      }
    }

    similar_one = Tornex.Scheduler.QueryRegistry.merge_similar(query_one, state)
    similar_two = Tornex.Scheduler.QueryRegistry.merge_similar(query_two, state)

    assert %ExecutionUnit{
             parameters: [],
             key_owner: 1,
             nice: 20
           } = similar_one

    assert_unordered([Torngen.Client.Path.User.Basic, Torngen.Client.Path.User.Bounties], similar_one.paths)
    assert_unordered([^query_one, ^query_two], similar_one.parents)

    assert %ExecutionUnit{
             parameters: [],
             key_owner: 1,
             nice: 20
           } = similar_two

    assert_unordered([Torngen.Client.Path.User.Basic, Torngen.Client.Path.User.Bounties], similar_two.paths)
    assert_unordered([^query_one, ^query_two], similar_two.parents)
  end

  test "merge similar non-overlapping queries with no resource ID and different key owners" do
    # These queries are not overlapping as they do not have a resource ID so the resource owner is 
    # the resource ID the operation is running against.

    query_one =
      SpecQuery.new(key_owner: 1)
      |> SpecQuery.put_path(Torngen.Client.Path.User.Basic)
      |> then(&%{&1 | origin: self()})

    query_two =
      SpecQuery.new(key_owner: 2)
      |> SpecQuery.put_path(Torngen.Client.Path.User.Basic)
      |> then(&%{&1 | origin: self()})

    state = %{
      "user" => %{
        nil => %{
          "basic" => [query_one, query_two]
        }
      }
    }

    similar_one = Tornex.Scheduler.QueryRegistry.merge_similar(query_one, state)
    similar_two = Tornex.Scheduler.QueryRegistry.merge_similar(query_two, state)

    assert %Tornex.Scheduler.ExecutionUnit{
             key: nil,
             key_owner: 1,
             nice: 20,
             parameters: [],
             paths: [Torngen.Client.Path.User.Basic],
             parents: [^query_one]
           } = similar_one

    assert %Tornex.Scheduler.ExecutionUnit{
             key: nil,
             key_owner: 2,
             nice: 20,
             parameters: [],
             paths: [Torngen.Client.Path.User.Basic],
             parents: [^query_two]
           } = similar_two
  end

  test "merge similar overlapping queries with no resource ID and different key owners" do
    # These queries are overlapping despite not having a resource ID and different key
    # owners as the data is shared globally across all users.

    query_one =
      SpecQuery.new(key_owner: 1)
      |> SpecQuery.put_path(Torngen.Client.Path.Torn.Crimes)
      |> then(&%{&1 | origin: self()})

    query_two =
      SpecQuery.new(key_owner: 1)
      |> SpecQuery.put_path(Torngen.Client.Path.Torn.Items)
      |> then(&%{&1 | origin: self()})

    state = %{
      "torn" => %{
        nil => %{
          "crimes" => [query_one],
          "items" => [query_two]
        }
      }
    }

    similar_one = Tornex.Scheduler.QueryRegistry.merge_similar(query_one, state)
    similar_two = Tornex.Scheduler.QueryRegistry.merge_similar(query_two, state)

    assert %ExecutionUnit{
             parameters: [],
             key_owner: 1,
             nice: 20
           } = similar_one

    assert_unordered([Torngen.Client.Path.Torn.Crimes, Torngen.Client.Path.Torn.Items], similar_one.paths)

    assert %ExecutionUnit{
             parameters: [],
             key_owner: 1,
             nice: 20
           } = similar_two

    assert_unordered([Torngen.Client.Path.Torn.Crimes, Torngen.Client.Path.Torn.Items], similar_two.paths)
  end

  test "merge similar overlapping queries with the same resource ID" do
    query_one =
      SpecQuery.new(key_owner: 1)
      |> SpecQuery.put_path(Torngen.Client.Path.User.Id.Basic)
      |> SpecQuery.put_parameter!(:id, 2_383_326)
      |> then(&%{&1 | origin: self()})

    query_two =
      SpecQuery.new(key_owner: 1)
      |> SpecQuery.put_path(Torngen.Client.Path.User.Id.Faction)
      |> SpecQuery.put_parameter!(:id, 2_383_326)
      |> then(&%{&1 | origin: self()})

    state = %{
      "user" => %{
        {:id, 2_383_326} => %{
          "basic" => [query_one],
          "faction" => [query_two]
        }
      }
    }

    similar_one = Tornex.Scheduler.QueryRegistry.merge_similar(query_one, state)
    similar_two = Tornex.Scheduler.QueryRegistry.merge_similar(query_two, state)

    assert %ExecutionUnit{
             parameters: [{:id, 2_383_326}],
             key_owner: 1,
             nice: 20
           } = similar_one

    assert_unordered(
      [Torngen.Client.Path.User.Id.Basic, Torngen.Client.Path.User.Id.Faction],
      similar_one.paths |> IO.inspect()
    )

    assert_unordered([^query_one, ^query_two], similar_one.parents)

    assert %ExecutionUnit{
             parameters: [{:id, 2_383_326}],
             key_owner: 1,
             nice: 20
           } = similar_two

    assert_unordered([Torngen.Client.Path.User.Id.Basic, Torngen.Client.Path.User.Id.Faction], similar_two.paths)
    assert_unordered([^query_one, ^query_two], similar_two.parents)
  end

  test "merge similar non-overlapping with different resource IDs" do
    query_one =
      SpecQuery.new(key_owner: 1)
      |> SpecQuery.put_path(Torngen.Client.Path.User.Id.Basic)
      |> SpecQuery.put_parameter!(:id, 2_383_326)
      |> then(&%{&1 | origin: self()})

    query_two =
      SpecQuery.new(key_owner: 1)
      |> SpecQuery.put_path(Torngen.Client.Path.User.Id.Basic)
      |> SpecQuery.put_parameter!(:id, 1)
      |> then(&%{&1 | origin: self()})

    state = %{
      "user" => %{
        {:id, 2_383_326} => %{
          "basic" => [query_one]
        },
        {:id, 1} => %{
          "basic" => [query_two]
        }
      }
    }

    similar_one = Tornex.Scheduler.QueryRegistry.merge_similar(query_one, state)
    similar_two = Tornex.Scheduler.QueryRegistry.merge_similar(query_two, state)

    assert query_one == similar_one
    assert query_two == similar_two
  end

  test "create simple subsets" do
    assert [] = Tornex.Scheduler.QueryRegistry.greedy_subsets([])

    query = SpecQuery.new(key_owner: 1) |> SpecQuery.put_path(Torngen.Client.Path.User.Basic)
    assert [[^query]] = Tornex.Scheduler.QueryRegistry.greedy_subsets([query])
  end

  test "state removal" do
    user_profile_basic =
      Tornex.SpecQuery.new()
      |> Tornex.SpecQuery.put_path(Torngen.Client.Path.User.Profile)
      |> Tornex.SpecQuery.put_path(Torngen.Client.Path.User.Basic)
      |> then(&%{&1 | origin: self()})

    user_one_profile =
      Tornex.SpecQuery.new()
      |> Tornex.SpecQuery.put_path(Torngen.Client.Path.User.Id.Profile)
      |> Tornex.SpecQuery.put_parameter!(:id, 1)
      |> then(&%{&1 | origin: self()})

    state = %{
      "user" => %{
        nil => %{
          "profile" => [user_profile_basic],
          "basic" => [user_profile_basic]
        },
        {:id, 1} => %{
          "profile" => [user_one_profile]
        }
      }
    }

    new_state =
      Tornex.Scheduler.QueryRegistry.remove(
        state,
        %Tornex.Scheduler.ExecutionUnit{
          parents: [user_profile_basic],
          paths: [Torngen.Client.Path.User.Profile, Torngen.Client.Path.User.Basic]
        }
      )

    assert %{"user" => %{{:id, 1} => %{"profile" => [^user_one_profile]}}} = new_state
    assert not is_map_key(new_state |> Map.get("user"), nil)
  end

  test "state removal of multiple queries" do
    user_one_profile =
      Tornex.SpecQuery.new()
      |> Tornex.SpecQuery.put_path(Torngen.Client.Path.User.Id.Profile)
      |> Tornex.SpecQuery.put_parameter!(:id, 1)
      |> then(&%{&1 | origin: self()})

    user_one_profile_bounties =
      Tornex.SpecQuery.new()
      |> Tornex.SpecQuery.put_path(Torngen.Client.Path.User.Id.Profile)
      |> Tornex.SpecQuery.put_path(Torngen.Client.Path.User.Id.Bounties)
      |> Tornex.SpecQuery.put_parameter!(:id, 1)
      |> then(&%{&1 | origin: self()})

    state = %{
      "user" => %{
        {:id, 1} => %{
          "profile" => [user_one_profile, user_one_profile_bounties],
          "bounties" => [user_one_profile_bounties]
        }
      }
    }

    state_remaining =
      Tornex.Scheduler.QueryRegistry.remove(
        state,
        %Tornex.Scheduler.ExecutionUnit{
          parents: [user_one_profile_bounties],
          paths: [Torngen.Client.Path.User.Id.Profile, Torngen.Client.Path.User.Id.Bounties]
        }
      )

    assert %{"user" => %{{:id, 1} => %{"profile" => [^user_one_profile]}}} = state_remaining

    state_none_remaining =
      Tornex.Scheduler.QueryRegistry.remove(
        state,
        %Tornex.Scheduler.ExecutionUnit{
          parents: [user_one_profile_bounties, user_one_profile],
          paths: [Torngen.Client.Path.User.Id.Profile, Torngen.Client.Path.User.Id.Bounties]
        }
      )

    assert not is_map_key(state_none_remaining, "user")
  end

  test "state removal of non-existent queries" do
    user_one_profile =
      Tornex.SpecQuery.new()
      |> Tornex.SpecQuery.put_path(Torngen.Client.Path.User.Id.Profile)
      |> Tornex.SpecQuery.put_parameter!(:id, 1)
      |> then(&%{&1 | origin: self()})

    user_one_bounties =
      Tornex.SpecQuery.new()
      |> Tornex.SpecQuery.put_path(Torngen.Client.Path.User.Id.Bounties)
      |> Tornex.SpecQuery.put_parameter!(:id, 1)
      |> then(&%{&1 | origin: self()})

    state = %{
      "user" => %{
        {:id, 1} => %{
          "profile" => [user_one_profile]
        }
      }
    }

    new_state =
      Tornex.Scheduler.QueryRegistry.remove(
        state,
        %Tornex.Scheduler.ExecutionUnit{
          parents: [user_one_bounties],
          paths: [Torngen.Client.Path.User.Id.Bounties]
        }
      )

    assert ^state = new_state
  end
end
