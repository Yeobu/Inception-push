FROM    debian:buster

RUN     apt-get update && apt-get install -y \
        mariadb-server \
        mariadb-client \
        && rm -rf /var/lib/apt/lists/*

RUN	mkdir -p /var/run/mysqld \
        && chown -R mysql:mysql /var/run/mysqld \
        && chmod 777 /var/run/mysqld 

COPY    ./tools/entrypoint.sh /usr/local/bin/
COPY    ./tools/ask_pw.sql /

EXPOSE  3306

CMD     ["entrypoint.sh" ]
