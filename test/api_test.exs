defmodule Tornex.Test.API do
  @test_api_key "asdf1234asdf1234"
  @comment_string "&comment=Tornex"

  use ExUnit.Case

  test "current_user_resource_url" do
    assert Tornex.API.query_to_url(%Tornex.Query{
             resource: "user",
             key: @test_api_key,
             selections: []
           }) == "/user/?selections=&key=" <> @test_api_key <> @comment_string
  end

  test "other_user_resource_url" do
    assert Tornex.API.query_to_url(%Tornex.Query{
             resource: "user",
             resource_id: 1,
             key: @test_api_key,
             selections: []
           }) == "/user/1?selections=&key=" <> @test_api_key <> @comment_string
  end

  test "current_user_selection_url" do
    assert Tornex.API.query_to_url(%Tornex.Query{
             resource: "user",
             key: @test_api_key,
             selections: ["basic"]
           }) == "/user/?selections=basic&key=" <> @test_api_key <> @comment_string

    assert Tornex.API.query_to_url(%Tornex.Query{
             resource: "user",
             key: @test_api_key,
             selections: ["basic", "attacks"]
           }) == "/user/?selections=basic%2Cattacks&key=" <> @test_api_key <> @comment_string
  end

  test "other_user_selection_url" do
    assert Tornex.API.query_to_url(%Tornex.Query{
             resource: "user",
             resource_id: 1,
             key: @test_api_key,
             selections: ["basic"]
           }) == "/user/1?selections=basic&key=" <> @test_api_key <> @comment_string

    assert Tornex.API.query_to_url(%Tornex.Query{
             resource: "user",
             resource_id: 1,
             key: @test_api_key,
             selections: ["basic", "attacks"]
           }) == "/user/1?selections=basic%2Cattacks&key=" <> @test_api_key <> @comment_string
  end

  test "ee_basic_user_requeset" do
    assert {:error, {:api, 2}} ==
             Tornex.API.torn_get(%Tornex.Query{
               resource: "user",
               resource_id: 1,
               key: @test_api_key,
               selections: ["basic"]
             })
  end
end
