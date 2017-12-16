FROM docker/compose:1.17.1
COPY docker-compose.yml entrypoint.sh /opt/docker/
WORKDIR /opt/docker
ENTRYPOINT ["sh", "/opt/docker/entrypoint.sh"]
CMD []