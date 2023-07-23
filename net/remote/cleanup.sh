#!/usr/bin/env bash

set -x
! tmux list-sessions || tmux kill-session
declare sudo=
if sudo true; then
  sudo="sudo -n"
fi

echo "pwd: $(pwd)"
for pid in xandeum/*.pid; do
  pgid=$(ps opgid= "$(cat "$pid")" | tr -d '[:space:]')
  if [[ -n $pgid ]]; then
    $sudo kill -- -"$pgid"
  fi
done
if [[ -f xandeum/netem.cfg ]]; then
  xandeum/scripts/netem.sh delete < xandeum/netem.cfg
  rm -f xandeum/netem.cfg
fi
xandeum/scripts/net-shaper.sh cleanup
for pattern in validator.sh boostrap-leader.sh xandeum- remote- iftop validator client node; do
  echo "killing $pattern"
  pkill -f $pattern
done
