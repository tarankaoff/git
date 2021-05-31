# ClickHouse insert/select data example

## Requirements

- `docker`

## Resources

- https://clickhouse.tech/docs/ru/
- https://hub.docker.com/r/yandex/clickhouse-server
- https://github.com/ClickHouse/ClickHouse/tree/master/docker/server

## Working with example

- To start ClickHouse server in docker container, initialize DB, create user/table and insert data run:
```bash
./run-example.sh start
```
- To get from ClickHouse previously inserted data run:
```bash
./run-example.sh get
```
- To clear ClickHouse server installation with all data run:
```bash
./run-example.sh stop
```
