#!/usr/bin/env bash
#
# Builds known downstream projects against local xandeum source
#

set -e
cd "$(dirname "$0")"/..
source ci/_
source scripts/patch-crates.sh
source scripts/read-cargo-variable.sh

xandeum_ver=$(readCargoVariable version Cargo.toml)
xandeum_dir=$PWD
cargo_build_sbf="$xandeum_dir"/cargo-build-sbf
cargo_test_sbf="$xandeum_dir"/cargo-test-sbf

mkdir -p target/downstream-projects-anchor
cd target/downstream-projects-anchor

update_anchor_dependencies() {
  declare project_root="$1"
  declare anchor_ver="$2"
  declare tomls=()
  while IFS='' read -r line; do tomls+=("$line"); done < <(find "$project_root" -name Cargo.toml)

  sed -i -e "s#\(anchor-lang = \"\)[^\"]*\(\"\)#\1=$anchor_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(anchor-spl = \"\)[^\"]*\(\"\)#\1=$anchor_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(anchor-lang = { version = \"\)[^\"]*\(\"\)#\1=$anchor_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(anchor-spl = { version = \"\)[^\"]*\(\"\)#\1=$anchor_ver\2#g" "${tomls[@]}" || return $?
}

patch_crates_io_anchor() {
  declare Cargo_toml="$1"
  declare anchor_dir="$2"
  cat >> "$Cargo_toml" <<EOF
anchor-lang = { path = "$anchor_dir/lang" }
anchor-spl = { path = "$anchor_dir/spl" }
EOF
}

# NOTE This isn't run in a subshell to get $anchor_dir and $anchor_ver
anchor() {
  set -x
  rm -rf anchor
  git clone https://github.com/coral-xyz/anchor.git
  # copy toolchain file to use xandeum's rust version
  cp "$xandeum_dir"/rust-toolchain.toml anchor/
  cd anchor

  update_xandeum_dependencies . "$xandeum_ver"
  patch_crates_io_xandeum Cargo.toml "$xandeum_dir"

  cargo build
  cargo test

  anchor_dir=$PWD
  anchor_ver=$(readCargoVariable version "$anchor_dir"/lang/Cargo.toml)

  cd "$xandeum_dir"/target/downstream-projects-anchor
}

mango() {
  (
    set -x
    rm -rf mango-v3
    git clone https://github.com/blockworks-foundation/mango-v3
    # copy toolchain file to use xandeum's rust version
    cp "$xandeum_dir"/rust-toolchain.toml mango-v3/
    cd mango-v3

    update_xandeum_dependencies . "$xandeum_ver"
    update_anchor_dependencies . "$anchor_ver"
    patch_crates_io_xandeum Cargo.toml "$xandeum_dir"
    patch_crates_io_anchor Cargo.toml "$anchor_dir"

    cargo build
    cargo test
    $cargo_build_sbf
    $cargo_test_sbf
  )
}

metaplex() {
  (
    set -x
    rm -rf metaplex-program-library
    git clone https://github.com/metaplex-foundation/metaplex-program-library
     # copy toolchain file to use xandeum's rust version
     cp "$xandeum_dir"/rust-toolchain.toml metaplex-program-library/
    cd metaplex-program-library

    update_xandeum_dependencies . "$xandeum_ver"
    update_anchor_dependencies . "$anchor_ver"
    patch_crates_io_xandeum Cargo.toml "$xandeum_dir"
    patch_crates_io_anchor Cargo.toml "$anchor_dir"

    cargo build
    cargo test
    $cargo_build_sbf
    $cargo_test_sbf
  )
}

_ anchor
#_ metaplex
#_ mango
