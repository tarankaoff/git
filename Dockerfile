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


RUN echo "#!/bin/bash" > /script.sh
RUN echo "" >> /script.sh
RUN echo "/etc/init.d/clickhouse-server start" >> /script.sh
RUN echo '/usr/bin/clickhouse-client --host=127.0.0.1 --user=default --password=test123 --query "CREATE DATABASE IF NOT EXISTS test"' >> /script.sh
RUN echo '/usr/bin/clickhouse-client --host=127.0.0.1 --user=default --password=test123 --query="CREATE TABLE test.test2 ( year Int16, amount Int16 ) ENGINE = Log"' >> /script.sh
RUN echo 'cat info.csv | clickhouse-client --database=test --query="INSERT INTO test.test2 FORMAT CSV" --password=test123' >> /script.sh


RUN echo "/bin/bash" >> /script.sh

RUN echo 'exec "$@"' >> /script.sh

RUN chmod +x /script.sh
ENTRYPOINT ["/script.sh"]
CMD ["clickhouse"]

