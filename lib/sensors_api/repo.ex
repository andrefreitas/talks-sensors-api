defmodule SensorsApi.Repo do
  use Ecto.Repo,
    otp_app: :sensors_api,
    adapter: Ecto.Adapters.Postgres
end
