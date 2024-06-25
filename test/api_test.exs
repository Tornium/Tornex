defmodule Tornix.Test.API do
  @test_api_key "asdf1234asdf1234"
  @comment_string "&comment=Tornix"

  use ExUnit.Case

  test "current_user_resource_url" do
    assert Tornix.API.query_to_url(%Tornix.Query{
             resource: "user",
             key: @test_api_key,
             selections: []
           }) == "/user/?selections=&key=" <> @test_api_key <> @comment_string
  end

  test "other_user_resource_url" do
    assert Tornix.API.query_to_url(%Tornix.Query{
             resource: "user",
             resource_id: 1,
             key: @test_api_key,
             selections: []
           }) == "/user/1?selections=&key=" <> @test_api_key <> @comment_string
  end

  test "current_user_selection_url" do
    assert Tornix.API.query_to_url(%Tornix.Query{
             resource: "user",
             key: @test_api_key,
             selections: ["basic"]
           }) == "/user/?selections=basic&key=" <> @test_api_key <> @comment_string

    assert Tornix.API.query_to_url(%Tornix.Query{
             resource: "user",
             key: @test_api_key,
             selections: ["basic", "attacks"]
           }) == "/user/?selections=basic%2Cattacks&key=" <> @test_api_key <> @comment_string
  end

  test "other_user_selection_url" do
    assert Tornix.API.query_to_url(%Tornix.Query{
             resource: "user",
             resource_id: 1,
             key: @test_api_key,
             selections: ["basic"]
           }) == "/user/1?selections=basic&key=" <> @test_api_key <> @comment_string

    assert Tornix.API.query_to_url(%Tornix.Query{
             resource: "user",
             resource_id: 1,
             key: @test_api_key,
             selections: ["basic", "attacks"]
           }) == "/user/1?selections=basic%2Cattacks&key=" <> @test_api_key <> @comment_string
  end

  test "ee_basic_user_requeset" do
    assert {:error, {:api, 2}} ==
             Tornix.API.torn_get(%Tornix.Query{
               resource: "user",
               resource_id: 1,
               key: @test_api_key,
               selections: ["basic"]
             })
  end
end
