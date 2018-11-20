defmodule SensorsApi.MeasurementProducerQueued do
  alias SensorsApi.Queue

  require Logger

  use GenStage

  def start_link(args) do
    GenStage.start_link(__MODULE__, args, name: args[:name] || __MODULE__)  
  end

  def init(%{queue_ref: queue_ref}) do
    state = %{queue_ref: queue_ref}
    {:producer, state}
  end

  def notify do
    GenStage.cast(__MODULE__, :notify)
  end

  def handle_cast(:notify, state) do
    {:noreply, [:notify], state}
  end

  def handle_demand(demand, state = %{queue_ref: queue_ref}) do
    events = Queue.dequeue(queue_ref, demand) 
    
    Logger.debug("Handled demand #{demand} with #{length(events)} events")
    {:noreply, events, state}
  end
end
