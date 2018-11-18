defmodule SensorsApi do
  use Application
  
  def start(_type, _args) do
    children = [
      SensorsApi.Repo,
      {SensorsApi.MeasurementProducer, %{queue_ref: SensorsApi.Queue}},
      SensorsApi.MeasurementConsumer,
      Plug.Cowboy.child_spec(scheme: :http, plug: SensorsApi.API, options: [port: 4001])
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
