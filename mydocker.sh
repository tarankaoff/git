#!/bin/bash

HOME_DIR=/var/lib/docker


case “$1” in
    start)
			cd $HOME_DIR
            docker build -t example .
            docker run -t example .
            ;;
   stop)
			CONTAINER_ID=$(docker ps | grep example| awk '{print $1}')
			docker stop $CONTAINER_ID
           ;;
   show_db)
			CONTAINER_ID=$(docker ps | grep example| awk '{print $1}')
          docker exec $CONTAINER_ID bash -c "clickhouse-client --host=127.0.0.1 --user=default --password=test123 --query='SELECT * from test.test2;'"
            ;;
        *)
          echo “Usage: /mydocker.sh start|stop|show_db”
          exit 1
          ;;
    esac