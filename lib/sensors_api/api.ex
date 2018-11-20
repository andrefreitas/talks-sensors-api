defmodule SensorsApi.API do
  use Plug.Router

  alias SensorsApi.Repo
  alias SensorsApi.Queue
  alias SensorsApi.Measurement
  alias SensorsApi.MeasurementProducerBuffered
  alias SensorsApi.MeasurementProducerQueued

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(:dispatch)

  post "/test" do 
    send_resp(conn, 200, "success")
  end

  post "/measurement" do
    measurement(conn)
    |> Repo.insert!()

    send_resp(conn, 201, "created")
  end

  post "v2/measurement" do
    measurement(conn)
    |> MeasurementProducerBuffered.sync_notify()

    send_resp(conn, 202, "accepted")
  end

  post "v3/measurement" do 
    Queue.enqueue(Queue, measurement(conn))
    MeasurementProducerQueued.notify()

    send_resp(conn, 202, "accepted")
  end

  defp measurement(conn), do: struct(Measurement, measurement_params(conn))

  defp measurement_params(conn) do
    params = conn.body_params

    %{
      date: params["date"],
      wind_speed: params["wind_speed"],
      temperature: params["temperature"]
    }
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
