defmodule SensorsApi do
  use Application
  
  def start(_type, _args) do
    children = [
      SensorsApi.Repo,
      SensorsApi.Queue,
      SensorsApi.MeasurementProducerBuffered,
      {SensorsApi.MeasurementProducerQueued, producer_queued_args()},
      Supervisor.child_spec({SensorsApi.MeasurementConsumer, consumer_buffered_args()}, id: :consumer1),
      Supervisor.child_spec({SensorsApi.MeasurementConsumer, consumer_queued_args()}, id: :consumer2),
      Plug.Cowboy.child_spec(webserver_args())
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end

  def producer_queued_args, do: %{queue_ref: SensorsApi.Queue}
  def consumer_buffered_args, do: %{name: :consumer_buffered, producer: SensorsApi.MeasurementProducerBuffered}
  def consumer_queued_args, do: %{name: :consumer_queued, producer: SensorsApi.MeasurementProducerQueued}
  def webserver_args, do: [scheme: :http, plug: SensorsApi.API, options: [port: 4001]] 
end
