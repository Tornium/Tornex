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

defmodule Tornex.Test.SpecQuery do
  use ExUnit.Case

  test "test_put_path" do
    query = Tornex.SpecQuery.new()

    assert %Tornex.SpecQuery{parameters: [], paths: [Tornex.Mock.TorngenPath]} ==
             Tornex.SpecQuery.put_path(query, Tornex.Mock.TorngenPath)
  end

  test "test_put_parameter" do
    query = Tornex.SpecQuery.new()

    assert_raise Protocol.UndefinedError, fn -> Tornex.SpecQuery.put_parameter(query, :foo, self()) end

    assert %Tornex.SpecQuery{parameters: [{:foo, "bar"}], paths: []} ==
             Tornex.SpecQuery.put_parameter(query, :foo, "bar")
  end

  test "test_uri" do
    Tornex.SpecQuery.new()
    # FIXME: Replace torngen-generated path with mock
    |> Tornex.SpecQuery.put_path(Torngen.Client.Path.Faction.Basic)
    |> Tornex.SpecQuery.uri()
    |> URI.to_string()
    |> (& assert &1 == "https://api.torn.com/v2/faction/?selections=basic").()

    Tornex.SpecQuery.new()
    |> Tornex.SpecQuery.put_path(Torngen.Client.Path.Faction.Id.Basic)
    |> Tornex.SpecQuery.put_path(Torngen.Client.Path.Faction.Id.Members)
    |> Tornex.SpecQuery.put_parameter(:id, 1)
    |> Tornex.SpecQuery.uri()
    |> URI.to_string()
    |> (& assert &1 == "https://api.torn.com/v2/faction/1/?selections=members,basic").()

    Tornex.SpecQuery.new()
    |> Tornex.SpecQuery.put_path(Torngen.Client.Path.Faction.Id.Chains)
    |> Tornex.SpecQuery.put_path(Torngen.Client.Path.Faction.Id.Basic)
    |> Tornex.SpecQuery.put_parameter(:id, 89)
    |> Tornex.SpecQuery.put_parameter(:limit, 100)
    |> Tornex.SpecQuery.uri()
    |> URI.to_string()
    |> (& assert &1 == "https://api.torn.com/v2/faction/89/?selections=basic,chains&limit=100").()
  end
end
