defmodule CacheTest do
  use ExUnit.Case, async: true
  doctest Cache

  setup do
    names = ["name1", "name2"]
    key = :group

    start_supervised!(Cache)

    Cache.write(key, names)
    %{names: names, key: key}
  end

  test "write", %{names: names} do
    assert {:ok, %{group_two: ^names}} = Cache.write(:group_two, names)
  end

  test "read", %{names: names, key: key} do
    assert {:ok, ^names} = Cache.read(key)
  end

  test "delete", %{key: key} do
    assert {:ok, %{}} = Cache.delete(key)
  end

  test "clear" do
    assert {:ok} = Cache.clear()
  end

  test "exist?", %{key: key} do
    assert {:ok, true} = Cache.exist?(key)
  end
end
