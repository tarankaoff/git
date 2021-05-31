#!/usr/bin/env bash

cd "$( dirname "${BASH_SOURCE[0]}" )"

case "$1" in
  start)
    docker compose up -d clickhouse
    ;;
  stop)
    docker compose down
    ;;
  get)
    docker compose up clickhouse_client
    ;;
  *)
    echo "Usage: ./run-example.sh start|get|stop"
    exit 1
    ;;
esac
