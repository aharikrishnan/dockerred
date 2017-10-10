FROM alpine:edge

RUN apk add --update \
      # Shell
      bash \
      # C lang
      gcc \
      g++ \
      make \
      # VCS
      git \
      # Compression
      zlib \
      bzip2 \
      tar \
      # SSL and SSH
      libressl \
      openssh-client \
      rsync \
      # Utils
      curl \
      file \
      patch \
      readline-dev \
      tini

# User Management
RUN apk add --update sudo openssh
RUN ssh-keygen -A

ARG uid
ARG gid
ARG user
ARG pass

RUN \
      adduser -D -u "$uid" -s /bin/bash -h "/home/$user" "$user" && \
      (echo "$user:$pass" | chpasswd) && \
      chown -R "$uid:$gid" "/home/$user" && \
      # Give coffee making powers to user
      (echo "%sudo ALL=(ALL) ALL" | tee -a /etc/sudoers) && \
      addgroup -S sudo && \
      addgroup "$user" sudo

# Service management

ADD s6-overlay-amd64.tar.gz /
RUN \
      addgroup s6 && \
      addgroup "$user" s6

ADD root /

#RUN \
      #chown -R root:s6 /etc/services.d /var/run && \
      #chmod g+w /etc/services.d /var/run

#USER "$user"
#WORKDIR "/home/$user"
#ADD ssh "home/$user/.ssh"

