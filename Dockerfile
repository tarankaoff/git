FROM debian

RUN apt-get update
RUN apt-get install -y apt-transport-https ca-certificates dirmngr
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E0C56BD4

RUN echo "deb https://repo.clickhouse.tech/deb/stable/ main/" > /etc/apt/sources.list.d/clickhouse.list
RUN apt-get update





