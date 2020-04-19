defmodule Cache do
  use GenServer

  @name CASH

  # client api
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts ++ [name: CASH])
  end

  def write(name, nicknames) do
    GenServer.call(@name, {:write, name, nicknames})
  end

  def read(name) do
    GenServer.call(@name, {:read, name})
  end

  def delete(name) do
    GenServer.call(@name, {:delete, name})
  end

  def clear do
    GenServer.call(@name, :clear)
  end

  def exist?(key) do
    GenServer.call(@name, {:exist, key})
  end

  # genserver callbacks
  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:write, name, nicknames}, _from, state) do
    new_state = Map.put(state, name, nicknames)
    {:reply, {:ok, new_state}, new_state}
  end

  def handle_call({:read, name}, _from, state) do
    {:reply, Map.fetch(state, name), state}
  end

  def handle_call({:delete, name}, _from, state) do
    new_state = Map.delete(state, name)
    {:reply, {:ok, new_state}, new_state}
  end

  def handle_call(:clear, _from, _state) do
    {:reply, {:ok}, %{}}
  end

  def handle_call({:exist, key}, _from, state) do
    {:reply, {:ok, Map.has_key?(state, key)}, state}
  end
end
