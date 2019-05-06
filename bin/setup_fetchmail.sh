#!/bin/sh
set -x # trace
# set -e # exit on erros in pipe

# ni evitas sudo / root metante
# la agordon en dosierujojn de la nuna uzanto
fetchmailrc=.fetchmailrc
# certs=${HOME}/etc/certs
certs=/etc/ssl/certs

# La variabloj ${POP3_SERVER} ${POP3_USER} ${POP3_PASSWORD}
# devos veni de ekstere, ekz. docker-compose.yml

# se .fetchmailrc ankoraŭ mankas, kreu ĝin uzante variablojn el la ĉirkaŭajo
#
if [ ! -e ${fetchmailrc} ]; then
    POP3_SERVER=$(cat /run/secrets/voko-tomocero.pop3_server)
    POP3_USER=$(cat /run/secrets/voko-tomocero.pop3_user)
    POP3_PASSWORD=$(cat /run/secrets/voko-tomocero.pop3_password)
    
    #mkdir -p ${certs}
    #echo quit | openssl s_client -CApath /etc/ssl/certs/ -connect "${POP3_SERVER}":995 -showcerts > "${certs}/${POP3_SERVER}.cert.pem"
    #c_rehash ${certs}
    echo "poll ${POP3_SERVER} proto pop3 user \"${POP3_USER}\" password ${POP3_PASSWORD} sslproto TLS1 sslcertck sslcertpath ${certs}" > ${fetchmailrc}
    chmod 0400  ${fetchmailrc}
fi
