#!/bin/bash

fw_depends postgresql crystal

shards update

crystal build --release --no-debug src/amber.cr

export CPU_COUNT=$(nproc --all)
export GC_MARKERS=1

export AMBER_ENV=production

export DB_URL_PARAMS="max_pool_size=2&max_idle_pool_size=2"
export DATABASE_URL="postgres://benchmarkdbuser:benchmarkdbpass@TFB-database/hello_world?$DB_URL_PARAMS"

for i in $(seq 1 $(nproc --all)); do
  ./amber &
done

wait
