#!/usr/bin/env bash
set -ex

cd "$(dirname "$0")"


platform=()
if [[ $(uname -m) = arm64 ]]; then
  # Ref: https://blog.jaimyn.dev/how-to-build-multi-architecture-docker-images-on-an-m1-mac/#tldr
  platform+=(--platform linux/amd64)
fi

docker build "${platform[@]}" -t xandeumlabs/rust .

read -r rustc version _ < <(docker run xandeumlabs/rust rustc --version)
[[ $rustc = rustc ]]
docker tag xandeumlabs/rust:latest xandeumlabs/rust:"$version"
docker push xandeumlabs/rust:"$version"
docker push xandeumlabs/rust:latest
