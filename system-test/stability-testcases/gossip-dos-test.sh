#!/usr/bin/env bash

set -e
cd "$(dirname "$0")"
SOLANA_ROOT="$(cd ../..; pwd)"

logDir="$PWD"/logs
rm -rf "$logDir"
mkdir "$logDir"

xandeumInstallDataDir=$PWD/releases
xandeumInstallGlobalOpts=(
  --data-dir "$xandeumInstallDataDir"
  --config "$xandeumInstallDataDir"/config.yml
  --no-modify-path
)

# Install all the xandeum versions
bootstrapInstall() {
  declare v=$1
  if [[ ! -h $xandeumInstallDataDir/active_release ]]; then
    sh "$SOLANA_ROOT"/install/xandeum-install-init.sh "$v" "${xandeumInstallGlobalOpts[@]}"
  fi
  export PATH="$xandeumInstallDataDir/active_release/bin/:$PATH"
}

bootstrapInstall "edge"
xandeum-install-init --version
xandeum-install-init edge
xandeum-gossip --version
xandeum-dos --version

killall xandeum-gossip || true
xandeum-gossip spy --gossip-port 8001 > "$logDir"/gossip.log 2>&1 &
xandeumGossipPid=$!
echo "xandeum-gossip pid: $xandeumGossipPid"
sleep 5
xandeum-dos --mode gossip --data-type random --data-size 1232 &
dosPid=$!
echo "xandeum-dos pid: $dosPid"

pass=true

SECONDS=
while ((SECONDS < 600)); do
  if ! kill -0 $xandeumGossipPid; then
    echo "xandeum-gossip is no longer running after $SECONDS seconds"
    pass=false
    break
  fi
  if ! kill -0 $dosPid; then
    echo "xandeum-dos is no longer running after $SECONDS seconds"
    pass=false
    break
  fi
  sleep 1
done

kill $xandeumGossipPid || true
kill $dosPid || true
wait || true

$pass && echo Pass
