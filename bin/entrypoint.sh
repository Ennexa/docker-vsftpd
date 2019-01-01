#!/bin/sh

addgroup -g "$FTP_UID" -S "$FTP_USER"
adduser -D -u "$FTP_UID" -G "$FTP_USER" -h "/home/$FTP_USER" -s /bin/false "$FTP_USER"

chown $FTP_USER:$FTP_USER /home/$FTP_USER/ -R
echo "$FTP_USER:$FTP_PASS" | /usr/sbin/chpasswd

envtpl /etc/vsftpd/vsftpd.conf.tpl > /etc/vsftpd/vsftpd.conf

/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
