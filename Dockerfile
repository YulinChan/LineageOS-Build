FROM ubuntu:latest

ADD build.sh /opt/build.sh

RUN chmod +x /opt/build.sh

CMD ENTRYPOINT ["sh", "-c", "/opt/build.sh"]
