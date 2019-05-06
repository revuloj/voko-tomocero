#!/bin/sh

if [ -e /etc/postfix/main.cf.d/10-custom.cf ]; then
    exit
fi

myhostname=$(cat /run/secrets/voko-tomocero.myhostname)
relayhost=$(cat /run/secrets/voko-tomocero.relayhost)
relayaddress=$(cat /run/secrets/voko-tomocero.relayaddress)
relaypassword=$(cat /run/secrets/voko-tomocero.relaypassword)
relayport=587

cat <<EOT >> /etc/postfix/main.cf.d/10-custom.cf
    myhostname = ${myhostname}
    relayhost = ${relayhost}:${relayport}

    smtp_sasl_auth_enable = yes  
    smtp_sasl_password_maps = hash:/etc/postfix/relay_user
    smtp_sasl_security_options = noanonymous
    smtp_sasl_tls_security_options = noanonymous   

    # for port :465
    #smtp_tls_wrappermode = yes
    #smtp_tls_security_level = encrypt
    #smtp_tls_CAfile = /etc/ssl/certs/Strato-smtp.pem
    #smtpd_sasl_authenticated_header = yes

    # for debuggin
    #debug_peer_level = 3
    #debug_peer_list = ${relayhost}
    #auth_debug=yes

    smtp_tls_enforce_peername = no
    sender_canonical_maps = hash:/etc/postfix/sender_canonical

    #smtpd_sasl_type = dovecot
    #smtpd_sasl_path = private/auth 
    #smtpd_sasl_type = cyrus 
    #cyrus_sasl_config_path = /etc/postfix/sasl/ 
    #smtp_sasl_mechanism_filter = plain, login
EOT

echo "$relayhost $relayaddress:$relaypassword" > /etc/postfix/relay_user
chmod 600 /etc/postfix/relay_user
postmap /etc/postfix/relay_user

echo "root $relayaddress" > /etc/postfix/sender_canonical
chmod 600 sender_canonical
postmap /etc/postfix/sender_canonical

#service postfix restart
