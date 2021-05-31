FROM debian

RUN apt-get update
RUN apt-get install -y apt-transport-https ca-certificates dirmngr
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E0C56BD4

RUN echo "deb https://repo.clickhouse.tech/deb/stable/ main/" > /etc/apt/sources.list.d/clickhouse.list
RUN apt-get update




RUN mkdir /etc/clickhouse-server/ /etc/clickhouse-server/users.d/

RUN echo -n "<yandex>\n\
\t<users>\n\
\t\t<default>\n\
\t\t\t<password remove='1' />\n\
\t\t\t<password_sha256_hex>" > /etc/clickhouse-server/users.d/default-password.xml
RUN echo -n "test123" | sha256sum | tr -d ' - \n -' >> /etc/clickhouse-server/users.d/default-password.xml
RUN echo "</password_sha256_hex>\n\
\t\t</default>\n\
\t</users>\n\
</yandex>\n" >> /etc/clickhouse-server/users.d/default-password.xml

RUN apt-get install -y clickhouse-server clickhouse-client net-tools procps nano


COPY info.csv /
