defmodule SensorsApi.API do
  use Plug.Router

  alias SensorsApi.Repo
  alias SensorsApi.Measurement

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(:dispatch)

  post "/measurement" do
    struct(Measurement, measurement_params(conn))
    |> Repo.insert!()

    send_resp(conn, 201, "created")
  end

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
