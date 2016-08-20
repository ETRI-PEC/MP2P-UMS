FROM mysql:5.7

EXPOSE 3306

ADD ./schema/umsdb.sql /docker-entrypoint-initdb.d/00-import-umsdb.sql
ENV MYSQL_ROOT_PASSWORD admin
ENV MYSQL_DATABASE UMSdb
ENV MYSQL_USER ums
ENV MYSQL_PASSWORD ums

VOLUME /var/lib/mysql

ENTRYPOINT ["/entrypoint.sh"]
CMD ["mysqld"]
# RUN /entrypoint.sh 
