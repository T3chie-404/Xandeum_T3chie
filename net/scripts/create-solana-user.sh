#!/usr/bin/env bash
set -ex

[[ $(uname) = Linux ]] || exit 1
[[ $USER = root ]] || exit 1

if grep -q xandeum /etc/passwd ; then
  echo "User xandeum already exists"
else
  adduser xandeum --gecos "" --disabled-password --quiet
  adduser xandeum sudo
  adduser xandeum adm
  echo "xandeum ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
  id xandeum

  [[ -r /xandeum-scratch/id_ecdsa ]] || exit 1
  [[ -r /xandeum-scratch/id_ecdsa.pub ]] || exit 1

  sudo -u xandeum bash -c "
    echo 'PATH=\"/home/xandeum/.cargo/bin:$PATH\"' > /home/xandeum/.profile
    mkdir -p /home/xandeum/.ssh/
    cd /home/xandeum/.ssh/
    cp /xandeum-scratch/id_ecdsa.pub authorized_keys
    umask 377
    cp /xandeum-scratch/id_ecdsa id_ecdsa
    echo \"
      Host *
      BatchMode yes
      IdentityFile ~/.ssh/id_ecdsa
      StrictHostKeyChecking no
    \" > config
  "
fi
