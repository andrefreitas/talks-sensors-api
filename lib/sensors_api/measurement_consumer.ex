defmodule SensorsApi.MeasurementConsumer do
  use GenStage
  
  require Logger

  alias SensorsApi.Repo
  alias SensorsApi.Queue

  def start_link(args) do 
    GenStage.start_link(__MODULE__, args, name: args[:name] || __MODULE__)
  end

  def init(%{producer: producer}) do
    {:consumer, [], subscribe_to: [{producer, min_demand: 1, max_demand: 10}]}
  end

  def handle_events(events, _from, state) do
    Logger.debug("Handling events #{length(events)}")
    
    Enum.each(events, &insert/1)
    {:noreply, [], state}
  end

  defp insert(:notify), do: :ignore
  defp insert(event), do: Repo.insert(event) 
end
