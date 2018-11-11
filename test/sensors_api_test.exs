defmodule SensorsApiTest do
  use ExUnit.Case
  doctest SensorsApi

  test "greets the world" do
    assert SensorsApi.hello() == :world
  end
end
