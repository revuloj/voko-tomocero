#!/bin/sh

sasl_password=$(cat /run/secrets/voko-tomocero.saslpassword)

#echo ${sasl_password} | saslpasswd2 -c -u $(postconf -h mydomain) -p tomocero
echo ${sasl_password} | saslpasswd2 -c -u tomocero -p tomocero
echo ${sasl_password} | saslpasswd2 -c -u localhost -p tomocero
chgrp postfix /etc/sasldb2
sasldblistusers2

mkdir -p /etc/postfix/sasl
echo <<EOT > /etc/postfix/sasl/smtpd.conf
pwcheck_method: auxprop
auxprop_plugin: sasldb
mech_list: PLAIN LOGIN CRAM-MD5 DIGEST-MD5 NTLM
EOT

#service postfix restart