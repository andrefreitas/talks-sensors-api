defmodule SensorsApi.Queue do
  use GenServer
  
  def start_link(args) do
    GenServer.start_link(__MODULE__, [], name: args[:name] || __MODULE__)
  end

  def init(_args) do
    state = %{queue: :queue.new(), length: 0}
    {:ok, state}
  end

  def enqueue(ref, event) do
    GenServer.call(ref, {:enqueue, event})
  end

  def dequeue(ref, demand) do 
    GenServer.call(ref, {:dequeue, demand})
  end

  def length(ref) do
    GenServer.call(ref, :length)
  end

  def handle_call({:enqueue, event}, _from, state = %{queue: queue, length: length}) do 
    state = %{state | queue: :queue.in(event, queue), length: length + 1}
    {:reply, :ok, state}
  end
  
  def handle_call({:dequeue, demand}, _from, state = %{queue: queue, length: length}) do 
    n = min(demand, length)
    {front, rest} = :queue.split(n, queue)

    state = %{state | queue: rest, length: length - n}
    {:reply, :queue.to_list(front), state} 
  end
  
  def handle_call(:length, _from, state = %{length: length}) do
    {:reply, length, state}
  end
end
