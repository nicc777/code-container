FROM debian:buster-slim AS code-base

RUN apt-get update
RUN apt-get install -y libterm-readline-gnu-perl
RUN apt-get install -y apt-utils
RUN apt-get upgrade -y
RUN apt-get install -y python3 python3-virtualenv openssh-client curl wget procps git python3-boto3 awscli zsh zsh-syntax-highlighting
RUN mkdir -p /code-user/projects
RUN useradd -c "Code User" -d /code-user -s /usr/bin/zsh code
RUN chown -R code /code-user
RUN chmod 700 /code-user
VOLUME [ "/code-user/projects" ]


# References: https://linuxize.com/post/how-to-install-node-js-on-debian-10/ and https://github.com/nodesource/distributions
FROM code-base AS code-node
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs


# References: https://github.com/cdr/code-server/blob/main/docs/guide.md
FROM code-node AS code-service
RUN curl -fsSL https://code-server.dev/install.sh | sh
RUN chown code /usr/bin/code-server
RUN mkdir -p /data
RUN chown -R code /data
VOLUME [ "/data" ]
EXPOSE 8081
EXPOSE 3000
EXPOSE 5000


FROM code-service
RUN mkdir -p /opt/bin
WORKDIR /opt/bin
COPY code-service-starter.sh .
RUN chmod 700 *
#USER code

CMD ["/opt/bin/code-service-starter.sh"]

