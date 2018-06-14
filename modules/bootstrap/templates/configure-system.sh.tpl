#!/bin/bash

# http://tldp.org/LDP/abs/html/options.html
set -o errexit
set -o nounset

#### LOGROTATE ####
aws s3 cp s3://${bootstrap_bucket}/logrotate /tmp/
sudo -u root cp /tmp/logrotate /etc/logrotate.d/emr
sudo -u root chmod 0644 /etc/logrotate.d/emr

aws s3 cp s3://${bootstrap_bucket}/logrotate.sh /tmp/
sudo -u root cp /tmp/logrotate.sh /etc/cron.hourly/logrotate-emr
sudo -u root chmod 0755 /etc/cron.hourly/logrotate-emr

#### SYSLOG ####
aws s3 cp s3://${bootstrap_bucket}/syslog.conf /tmp/
sudo -u root cp /tmp/syslog.conf /etc/rsyslog.d/25-emr.conf
sudo -u root chmod 0644 /etc/rsyslog.d/25-emr.conf
sudo -u root service rsyslog restart

### ZEPPELIN ###
sudo -u root mkdir -p /etc/zeppelin/conf/
aws s3 cp s3://${bootstrap_bucket}/shiro.ini /tmp/
sudo -u root cp /tmp/shiro.ini /etc/zeppelin/conf/shiro.ini

sudo -u root mkdir -p /etc/spark/conf/
aws s3 cp s3://${bootstrap_bucket}/log4j_spark.properties /tmp/
sudo -u root cp /tmp/log4j_spark.properties /etc/spark/conf/log4j.properties

aws s3 cp s3://${bootstrap_bucket}/log4j_zeppelin.properties /tmp/
sudo -u root cp /tmp/log4j_zeppelin.properties /etc/zeppelin/conf/log4j.properties

# Create a Self-Signed Cert for the Zeppelin UI
# Ideally you'd want to replace this with a PKI, but this will do for now
openssl genrsa -out zeppelin.key
openssl req -new -x509 -key zeppelin.key -out zeppelin.crt -subj "/C=US/ST=State/O=Company/CN=localhost"
keytool -keystore /tmp/keystore -import -alias zeppelin -file zeppelin.crt -trustcacerts -storepass ${zeppelin_keystore_password} -noprompt
openssl pkcs12 -inkey zeppelin.key -in zeppelin.crt -export -out zeppelin.pkcs12 -passout pass:${zeppelin_keystore_password}
keytool -importkeystore -srckeystore zeppelin.pkcs12 -srcstoretype PKCS12 -destkeystore /tmp/keystore -storepass ${zeppelin_keystore_password} -noprompt -srcstorepass ${zeppelin_keystore_password}
sudo -u root mv /tmp/keystore /etc/zeppelin/conf/keystore
