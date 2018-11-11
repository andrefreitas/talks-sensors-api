defmodule SensorsApi do
  use Application
  alias SensorsApi.API

  def start(_type, _args) do
    children = [
      SensorsApi.Repo,
      Plug.Cowboy.child_spec(scheme: :http, plug: API, options: [port: 4001])
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
