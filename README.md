# SensorsApi
Example API that demonstrates how GenStage can handle backpressure in a large scale of events

## Setup
Create database:

    mix ecto.create

Run migrations:
    
    mix ecto.migrate

## Usage
Start webserver with:

    iex -s mix


## API

__POST /measurement__

    curl -X POST -H "Content-Type: application/json" http://localhost:4001/measurement -d @test/data.json

__POST /v2/measurement__

    curl -X POST -H "Content-Type: application/json" http://localhost:4001/v2/measurement -d @test/data.json


## Benchmarks
Run HTTP benchmarks with:

    ./benchmarks.sh
