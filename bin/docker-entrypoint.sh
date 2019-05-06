#!/bin/sh
#set -e
#set -x

# laŭbezone kreu agordon por fetchmail kaj smtp - tio okazos nur se la dosieroj
# ankoraŭ mankas. Por ŝanĝi ilin necesas rekrei la procesumon voko-afido kun ŝanĝitaj sekretoj
# aŭ forigi .fetchmailrc kaj /etc/postfix/main.cf.d/10-custom.cf

setup_postfix.sh
setup_fetchmail.sh

/init
#exec "$@"