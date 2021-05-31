#!/bin/bash
set -e

sleep 10

clickhouse client --user="${CLICKHOUSE_USER}" --password="${CLICKHOUSE_PASSWORD}" -n <<-EOSQL
    CREATE DATABASE IF NOT EXISTS test;
    CREATE TABLE test.test2 ( year Int16, amount Int16 ) ENGINE = Log;
EOSQL

clickhouse client \
  --database="${CLICKHOUSE_DB}" \
  --user="${CLICKHOUSE_USER}" \
  --password="${CLICKHOUSE_PASSWORD}" \
  --query='INSERT INTO test.test2 FORMAT CSV' < /info.csv
