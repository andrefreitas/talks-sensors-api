defmodule SensorsApi.MeasurementConsumer do
  use GenStage
  
  alias SensorsApi.Repo

  def start_link(args) do 
    GenStage.start_link(__MODULE__, args, name: args[:name] || __MODULE__)
  end

  def init(_args) do
    {:consumer, [], subscribe_to: [SensorsApi.MeasurementProducer]}
  end

  def handle_events(events, _from, state) do 
    Enum.each(events, &Repo.insert/1)
    {:noreply, [], state}
  end
end
