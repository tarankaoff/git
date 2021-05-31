#!/bin/bash
set -e

clickhouse-client \
  --host "${CLICKHOUSE_HOST}" \
  --database="${CLICKHOUSE_DB}" \
  --user="${CLICKHOUSE_USER}" \
  --password="${CLICKHOUSE_PASSWORD}" \
  --query='SELECT * from test.test2;'
