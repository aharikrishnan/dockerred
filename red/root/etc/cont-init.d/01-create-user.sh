#!/usr/bin/with-contenv bash

#parameters username userid groupname groupid password
createUser () {
  userExists=$(cat /etc/passwd | grep "$1:")
  if [ -z "${userExists}" ]; then
    echo "Creating group ($3) with ($4) gid"
    addgroup -g ${4} ${3} #> /dev/null 2&>1
    _gid=$(cat /etc/group | grep ":$4:" | cut -d: -f1)

    #creating user
    echo "Creating user ($1) with uid ($2), gid ($_gid)."
    adduser -G $_gid -u ${2} -s /bin/bash -h "/home/$user" -D ${1}

    echo ${1}:${5} | chpasswd

    chown -R "${2}:${4}" "/home/${1}"
    addgroup "${1}" sudo
    #addgroup "${1}" s6
  fi
}

createUser $user $uid $group $gid $passwd
