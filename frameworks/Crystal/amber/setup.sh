#!/bin/bash

fw_depends postgresql crystal

shards update

crystal build --release --no-debug src/amber.cr

export CPU_COUNT=$(nproc --all)
export HALF_CPU_COUNT=$((((CPU_COUNT - 1) / 2) + 1))

export GC_MARKERS=$HALF_CPU_COUNT

export AMBER_ENV=production

export DATABASE_URL="postgres://benchmarkdbuser:benchmarkdbpass@TFB-database/hello_world"

for i in $(seq 1 $HALF_CPU_COUNT); do
  ./amber &
done

wait
