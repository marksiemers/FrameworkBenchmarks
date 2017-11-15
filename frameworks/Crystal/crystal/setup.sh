#!/bin/bash

fw_depends postgresql crystal

shards install

crystal build --release --no-debug server.cr -o server.out

export CPU_COUNT=$(nproc --all)
export HALF_CPU_COUNT=$((((CPU_COUNT - 1) / 2) + 1))

export GC_MARKERS=2

for i in $(seq 1 $HALF_CPU_COUNT); do
  ./server.out &
done

wait
