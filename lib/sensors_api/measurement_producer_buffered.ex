defmodule SensorsApi.MeasurementProducerBuffered do
  use GenStage

  def start_link(args) do
    GenStage.start_link(__MODULE__, [], name: args[:name] || __MODULE__)  
  end

  def init(_args) do
    {:producer, []}
  end

  def sync_notify(event, timeout \\ 5000) do
    GenStage.call(__MODULE__, {:notify, event}, timeout)
  end

  def handle_call({:notify, event}, _from, state) do
    {:reply, :ok, [event], state}
  end

  def handle_demand(_demand, state) do 
    {:noreply, [], state} # we don't care about demand
  end
end
