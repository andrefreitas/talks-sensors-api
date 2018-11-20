defmodule SensorsApi.MeasurementsRepo.Migrations.CreateMeasurement do
  use Ecto.Migration

  def change do
    create table(:measurement) do
      add :date, :string
      add :temperature, :float
      add :wind_speed, :float
    end
  end
end
