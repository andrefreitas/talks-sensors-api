defmodule SensorsApi.Measurement do
  use Ecto.Schema

  schema "measurement" do
    field(:date)
    field(:temperature, :float)
    field(:wind_speed, :float)
  end
end
