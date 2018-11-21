#!/bin/bash

REQUESTS=${REQUESTS:-5000}
REPORTS_DIR="benchmarks"

function apache_benchmark {
  endpoint=$1
  output=$2
  requests=$3
  
  ab -n $requests -c 4 -T 'application/json' -p test/data.json -e ${REPORTS_DIR}/${output} 127.0.0.1:4001${endpoint}
}

mkdir -p $REPORTS_DIR

apache_benchmark "/measurement" "v1-report.csv" $REQUESTS
apache_benchmark "/v2/measurement" "v2-report.csv" $REQUESTS
apache_benchmark "/v3/measurement" "v3-report.csv" $REQUESTS
