FROM instrumentisto/postfix
MAINTAINER <diestel@steloj.de>

RUN apk add --update --no-cache --virtual .tool-deps \
        fetchmail \
  && apk del .tool-deps \
  && rm -rf /var/cache/apk/* 

COPY bin/* /usr/local/bin/

#RUN useradd -ms /bin/bash -u 1074 tomocero
#WORKDIR /home/tomocero
#
#USER tomocero:users

ENTRYPOINT ["docker-entrypoint.sh"]


# for use from host:
# docker run -d -p 25:25 voko-tomocero
# fetchmail:
# docker run --rm voko-tomocero fetchmail
# for main.cf
# docker run --rm voko-tomocero postconf
# for master.cf
# docker run --rm voko-tomocero postconf -M