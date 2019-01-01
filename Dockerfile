FROM alpine

ENV \
  ALLOW_WRITEABLE_CHROOT=NO \
  ANONYMOUS_ENABLE=NO \
  ANON_MKDIR_WRITE_ENABLE=NO \
  ANON_UPLOAD_ENABLE=NO \
  BACKGROUND=NO \
  CHOWN_UPLOADS=NO \
  CHOWN_USERNAME=nobody \
  CHROOT_LOCAL_USER=YES \
  CHROOT_LIST_ENABLE=YES \
  CHROOT_LIST_FILE=/etc/vsftpd.chroot_list \
  CONNECT_FROM_PORT_20=YES \
  DIRMESSAGE_ENABLE=YES \
  DOWNLOAD_ENABLE=YES \
  FTP_PASS=Your_FTP_Password \
  FTP_UID=1001 \
  FTP_USER=user \
  LISTEN_IPV6=NO \
  LOCAL_ENABLE=YES \
  LOCAL_UMASK=022 \
  LS_RECURSE_ENABLE=NO \
  MAX_CLIENTS=10 \
  MAX_PER_IP=5 \
  PASSWD_CHROOT_ENABLE=YES \
  PASV_ADDRESS= \
  PASV_ENABLE=NO \
  PASV_MAX_PORT=0 \
  PASV_MIN_PORT=0 \
  SECCOMP_SANDBOX=NO \
  WRITE_ENABLE=YES \
  XFERLOG_ENABLE=YES

COPY bin/envtpl /usr/sbin/
COPY bin/entrypoint.sh /
COPY vsftpd.conf.tpl /etc/vsftpd/

RUN apk update \
  && apk upgrade \
  && apk --update --no-cache add vsftpd \
  && addgroup -S vsftpd \
  && adduser -D -H -G vsftpd -s /bin/false vsftpd \
  && chmod +x /entrypoint.sh /usr/sbin/envtpl

EXPOSE 21

ENTRYPOINT /entrypoint.sh
