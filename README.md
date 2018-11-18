# SensorsApi
Example API that demonstrates how GenStage can handle backpressure in a large scale of events

## Usage
Start webserver with:

    iex -s mix

## Benchmarks
Without GenStage:

    ab -n 1000 -c 4 -T 'application/json' -p test/data.json 127.0.0.1:4001/measurement

With GenStage:

    ab -n 1000 -c 4 -T 'application/json' -p test/data.json 127.0.0.1:4001/v2/measurement
