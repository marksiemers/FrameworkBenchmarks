#!/bin/bash

fw_depends postgresql crystal

shards update

crystal build --release --no-debug src/amber.cr

export GC_MARKERS=1

export AMBER_ENV=production

export CPU_COUNT=$(nproc --all)
export CPU_MULTIPLIER=2
export CONN_POOL_SIZE=$(($CPU_COUNT*$CPU_MULTIPLIER))
export DB_URL_PARAMS="max_pool_size=$CONN_POOL_SIZE&max_idle_pool_size=$CONN_POOL_SIZE"
export DATABASE_URL="postgres://benchmarkdbuser:benchmarkdbpass@TFB-database/hello_world?$DB_URL_PARAMS"

for i in $(seq 1 $(nproc --all)); do
  ./amber &
done

wait
