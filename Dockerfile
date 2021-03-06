FROM instrumentisto/postfix
MAINTAINER <diestel@steloj.de>
#https://wiki.alpinelinux.org/wiki/Hosting_Web/Email_services_on_Alpine#Postfix

RUN apk add --update --no-cache \
        cyrus-sasl fetchmail \
  && rm -rf /var/cache/apk/* 

# vd: https://github.com/just-containers/s6-overlay#executing-initialization-andor-finalization-tasks
COPY init.d/* /etc/cont-init.d/

#RUN useradd -ms /bin/ash -u 1074 tomocero
RUN adduser -D -u 1074 tomocero \
  && mkdir -p /var/mail && touch /var/mail/tomocero && chown tomocero:mail /var/mail/tomocero \
  && chmod o-r /var/mail/tomocero && chmod g+rw /var/mail/tomocero

# tio jam estas en instrumentisto/postfix
#ENTRYPOINT ["docker-entrypoint.sh"]
#CMD ["/usr/lib/postfix/master", "-d"]

# por uzo de docker-gastiganto:
# docker run -d -p 25:25 voko-tomocero

# fetchmail:
# docker run --rm -u 1074 voko-tomocero fetchmail
# aŭ se la procesumo jam funkcias kun postfix:
# docker  exec -u 1074 -it a948a76afdc3   fetchmail

# por listigi main.cf
# docker run --rm voko-tomocero postconf
# por listigi master.cf
# docker run --rm voko-tomocero postconf -M