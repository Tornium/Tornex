defmodule Tornex.Test.ListAssertion do
  @moduledoc """
  Tests for assertion for an unordered list.

  Source: https://elixirforum.com/t/assert-a-list-of-patterns-ignoring-order/46068/8
  """

  use ExUnit.Case, async: true
  import Tornex.ListAssertions

  test "all match" do
    assert_unordered([:foo, :bar, :baz], [:foo, :baz, :bar])
    assert_unordered([{:ok, _}, {:error, _}], [{:error, :bad}, {:ok, :good}])
  end

  test "duplicates" do
    assert_raise(ArgumentError, fn ->
      assert_unordered([{:ok, _}, {:error, _}], [{:error, :bad}, {:ok, :good}, {:ok, :bad}])
    end)
  end

  test "too few" do
    assert_raise(ArgumentError, fn ->
      assert_unordered([{:ok, _}, {:error, _}], [{:error, :bad}])
    end)
  end

  test "unknown" do
    assert_raise(ArgumentError, fn ->
      assert_unordered([{:ok, _}, {:error, _}], [:what])
    end)
  end
end
