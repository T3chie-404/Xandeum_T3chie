#!/usr/bin/env bash
set -ex

[[ $(uname) = Linux ]] || exit 1
[[ $USER = root ]] || exit 1

[[ -d /home/xandeum/.ssh ]] || exit 1

if [[ ${#SOLANA_PUBKEYS[@]} -eq 0 ]]; then
  echo "Warning: source xandeum-user-authorized_keys.sh first"
fi

# xandeum-user-authorized_keys.sh defines the public keys for users that should
# automatically be granted access to ALL testnets
for key in "${SOLANA_PUBKEYS[@]}"; do
  echo "$key" >> /xandeum-scratch/authorized_keys
done

sudo -u xandeum bash -c "
  cat /xandeum-scratch/authorized_keys >> /home/xandeum/.ssh/authorized_keys
"
