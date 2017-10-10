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
RUN apk add --update sudo

ARG id
ARG user
ARG pass

RUN \
      adduser -D -u "$id" -s /bin/bash -h "/home/$user" "$user" && \
      (echo "$user:$pass" | chpasswd) && \
      chown -R "$user:$user" "/home/$user" && \
      # Give coffee making powers to user
      (echo "%sudo ALL=(ALL) ALL" | tee -a /etc/sudoers) && \
      addgroup -S sudo && \
      addgroup "$user" sudo

# Service management

RUN apk add --update s6

RUN \
      addgroup s6 && \
      addgroup "$user" s6

RUN \
  mkdir /etc/services.d/consul-template/supervise/ && \
  mkfifo /etc/services.d/consul-template/supervise/control && \
  chown -R root:s6 /etc/services.d/consul-template && \
  chmod g+w /etc/services.d/consul-template/supervise/control /etc/services.d/consul-template

USER "$user"
WORKDIR "/home/$user"
ADD ssh .ssh

