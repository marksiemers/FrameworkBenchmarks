#!/bin/bash

fw_depends postgresql crystal

shards install

crystal build --release --no-debug server-postgres.cr

export CPU_COUNT=$(nproc --all)
export HALF_CPU_COUNT=$((((CPU_COUNT - 1) / 2) + 1))

export GC_MARKERS=$HALF_CPU_COUNT

export KEMAL_ENV=production

for i in $(seq 1 $HALF_CPU_COUNT); do
  ./server-postgres -p 8080 &
done

wait
